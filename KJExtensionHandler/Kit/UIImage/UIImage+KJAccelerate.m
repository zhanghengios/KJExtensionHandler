//
//  UIImage+KJAccelerate.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/24.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "UIImage+KJAccelerate.h"

@implementation UIImage (KJAccelerate)
/// 图片旋转
- (UIImage *)kj_rotateInRadians:(CGFloat)radians{
    const size_t width  = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext) return nil;
    CGContextDrawImage(bmContext, CGRectMake(0, 0, width, height), self.CGImage);
    UInt8 *data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data){
        CGContextRelease(bmContext);
        return nil;
    }
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    Pixel_8888 bgColor = {0, 0, 0, 0};
    vImageRotate_ARGB8888(&src, &dest, NULL, radians, bgColor, kvImageBackgroundColorFill);
    CGImageRef rotatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *newImg = [UIImage imageWithCGImage:rotatedImageRef];
    CGImageRelease(rotatedImageRef);
    CGContextRelease(bmContext);
    return newImg;
}

#pragma mark - 模糊处理
/// 模糊处理保留透明区域，范围0 ~ 1
- (UIImage*)kj_linearBlurryImageBlur:(CGFloat)blur{
    blur = MAX(MIN(blur,1),0);
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer, rgbOutBuffer;
    vImage_Error error;
    void *pixelBuffer, *convertBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    convertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    rgbOutBuffer.width = CGImageGetWidth(img);
    rgbOutBuffer.height = CGImageGetHeight(img);
    rgbOutBuffer.rowBytes = CGImageGetBytesPerRow(img);
    rgbOutBuffer.data = convertBuffer;
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    if (pixelBuffer == NULL) NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    void *rgbConvertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    vImage_Buffer outRGBBuffer;
    outRGBBuffer.width = CGImageGetWidth(img);
    outRGBBuffer.height = CGImageGetHeight(img);
    outRGBBuffer.rowBytes = CGImageGetBytesPerRow(img);
    outRGBBuffer.data = rgbConvertBuffer;
    /// box滤镜（模糊滤镜）
    error = vImageBoxConvolve_ARGB8888(&inBuffer,&outBuffer,NULL,0,0,boxSize,boxSize,NULL,kvImageEdgeExtend);
    if (error) NSLog(@"error from convolution %ld", error);
    
    /// 交换像素通道从BGRA到RGBA
    const uint8_t permuteMap[] = {2, 1, 0, 3};
    vImagePermuteChannels_ARGB8888(&outBuffer,&rgbOutBuffer,permuteMap,kvImageNoFlags);

    /// kCGImageAlphaPremultipliedLast 保留透明区域
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(rgbOutBuffer.data,
                                             rgbOutBuffer.width,
                                             rgbOutBuffer.height,
                                             8,
                                             rgbOutBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaPremultipliedLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(ctx);
    free(pixelBuffer);
    free(convertBuffer);
    free(rgbConvertBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);

    return returnImage;
}
/// 模糊处理
- (UIImage*)kj_blurImageWithRadius:(CGFloat)radius Color:(UIColor*)color MaskImage:(UIImage* _Nullable)maskImage{
    CGRect imageRect = {CGPointZero, self.size};
    UIImage *effectImage = self;
    BOOL hasBlur = radius > __FLT_EPSILON__;
    if (hasBlur) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);

        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
    
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);

        CGFloat inputRadius = radius * [[UIScreen mainScreen] scale];
        NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
        // force radius to be odd so that the three box-blur methodology works.
        if (radius % 2 != 1) radius += 1;
        vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);

        const int32_t divisor = 256;
        CGFloat s = 1.;
        CGFloat floatingPointSaturationMatrix[] = {
            0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
            0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
            0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                              0,                    0,                    0,  1,
        };
        NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
        int16_t saturationMatrix[matrixSize];
        for (NSUInteger i = 0; i < matrixSize; ++i) {
            saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
        }
        vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
        effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);

    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);

    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }

    // Add in color tint.
    if (color) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, color.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }

    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return outputImage;
}
#pragma mark - 形态操作
/// 均衡运算
- (UIImage*)kj_equalizationImage{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext) return nil;
    CGContextDrawImage(bmContext, CGRectMake(0,0,width,height), self.CGImage);
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data){
        CGContextRelease(bmContext);
        return nil;
    }
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    vImageEqualization_ARGB8888(&src, &dest, kvImageNoFlags);
    CGImageRef destImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* destImage = [UIImage imageWithCGImage:destImageRef];
    CGImageRelease(destImageRef);
    CGContextRelease(bmContext);
    return destImage;
}
/// 侵蚀
- (UIImage *)kj_erodeImage{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext) return nil;
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(bmContext, rect, self.CGImage);
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data){
        CGContextRelease(bmContext);
        return nil;
    }
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageErode_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    CGImageRef erodedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* eroded = [UIImage imageWithCGImage:erodedImageRef];
    CGImageRelease(erodedImageRef);
    CGContextRelease(bmContext);
    return eroded;
}
/// 形态膨胀/扩张
- (UIImage *)kj_dilateImage{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext) return nil;
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(bmContext, rect, self.CGImage);
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data){
        CGContextRelease(bmContext);
        return nil;
    }
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageDilate_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    CGImageRef dilatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* dilated = [UIImage imageWithCGImage:dilatedImageRef];
    CGImageRelease(dilatedImageRef);
    CGContextRelease(bmContext);
    return dilated;
}
/// 多倍侵蚀
- (UIImage *)kj_erodeImageWithIterations:(int)iterations{
    UIImage *dstImage = self;
    for (int i=0; i<iterations; i++) {
        dstImage = [dstImage kj_erodeImage];
    }
    return dstImage;
}
/// 形态多倍膨胀/扩张
- (UIImage *)kj_dilateImageWithIterations:(int)iterations{
    UIImage *dstImage = self;
    for (int i=0; i<iterations; i++) {
        dstImage = [dstImage kj_dilateImage];
    }
    return dstImage;
}
/// 梯度
- (UIImage *)kj_gradientImageWithIterations:(int)iterations{
    UIImage *dilated = [self kj_dilateImageWithIterations:iterations];
    UIImage *eroded = [self kj_erodeImageWithIterations:iterations];
    UIImage *dstImage = [dilated kj_imageBlendedWithImage:eroded blendMode:kCGBlendModeDifference alpha:1.0];
    return dstImage;
}
/// 顶帽运算
- (UIImage *)kj_tophatImageWithIterations:(int)iterations {
    UIImage *dilated = [self kj_dilateImageWithIterations:iterations];
    UIImage *dstImage = [self kj_imageBlendedWithImage:dilated blendMode:kCGBlendModeDifference alpha:1.0];
    return dstImage;
}
/// 黑帽运算
- (UIImage *)kj_blackhatImageWithIterations:(int)iterations {
    UIImage *eroded = [self kj_erodeImageWithIterations:iterations];
    UIImage *dstImage = [eroded kj_imageBlendedWithImage:self blendMode:kCGBlendModeDifference alpha:1.0];
    return dstImage;
}
// 混合函数
- (UIImage*)kj_imageBlendedWithImage:(UIImage *)overlayImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0,0,self.size.width,self.size.height)];
    [overlayImage drawAtPoint:CGPointZero blendMode:blendMode alpha:alpha];
    UIImage *blendedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blendedImage;
}
#pragma mark - 卷积处理
/// 卷积处理
- (UIImage*)kj_convolutionImageWithKernel:(int16_t*)kernel{
    const size_t w = self.size.width;
    const size_t h = self.size.height;
    const size_t bytes = w * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,w,h,8,bytes,space,kCGBitmapByteOrderDefault|kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!context) return nil;
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    UInt8 * data = (UInt8*)CGBitmapContextGetData(context);
    if (!data){
        CGContextRelease(context);
        return nil;
    }
    const size_t n = sizeof(UInt8) * w * h * 4;
    void * outt = malloc(n);
    vImage_Buffer src  = {data, h, w, bytes};
    vImage_Buffer dest = {outt, h, w, bytes};
    unsigned char bgColor[4] = {0, 0, 0, 0};
    vImageConvolve_ARGB8888(&src,&dest,NULL,0,0,kernel,3,3,1,bgColor,kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return resultImage;
}
/// 浮雕函数
- (UIImage*)kj_embossImage{
    return [self kj_convolutionImageWithKernel:emboss_kernel];
}
/// 锐化
- (UIImage*)kj_sharpenImage{
    return [self kj_convolutionImageWithKernel:sharpen_kernel];
}
/// 锐化
- (UIImage*)kj_sharpenImageWithIterations:(int)iterations{
    int k = iterations;
    int16_t kernel[9] = {
        -k,-k,-k,
        -k,8*k+1,-k,
        -k,-k,-k
    };
    return [self kj_convolutionImageWithKernel:kernel];
}
/// 高斯
- (UIImage*)kj_gaussianImage{
    return [self kj_convolutionImageWithKernel:gaussian_kernel];
}
/// 边缘检测
- (UIImage*)kj_marginImage{
    return [self kj_convolutionImageWithKernel:margin_kernel];
}
#pragma mark - 函数矩阵
/// 高斯矩阵
static int16_t gaussian_kernel[9] = {
    1, 2, 1,
    2, 4, 2,
    1, 2, 1
};
/// 边缘检测矩阵
static int16_t margin_kernel[9] = {
    -1, -1, -1,
     0,  0,  0,
     1,  1,  1
};
/// 锐化矩阵
static int16_t sharpen_kernel[9] = {
    -1, -1, -1,
    -1, 9, -1,
    -1, -1, -1
};
/// 浮雕矩阵
static int16_t emboss_kernel[9] = {
    -2, 0, 0,
     0, 1, 0,
     0, 0, 2
};
/// 侵蚀矩阵
static unsigned char morphological_kernel[9] = {
    1, 1, 1,
    1, 1, 1,
    1, 1, 1
};

@end
