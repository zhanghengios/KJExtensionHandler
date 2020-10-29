//
//  UIImage+KJProcessing.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIImage+KJScale.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (KJScale)

/// 等比改变图片尺寸
- (UIImage*)kj_cropImageWithAnySize:(CGSize)size{
    float scale = self.size.width/self.size.height;
    CGRect rect = CGRectZero;
    if (scale > size.width/size.height){
        rect.origin.x = (self.size.width - self.size.height * size.width/size.height)/2;
        rect.size.width  = self.size.height * size.width/size.height;
        rect.size.height = self.size.height;
    }else {
        rect.origin.y = (self.size.height - self.size.width/size.width * size.height)/2;
        rect.size.width  = self.size.width;
        rect.size.height = self.size.width/size.width * size.height;
    }
    CGImageRef imageRef   = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}
/// 等比缩小图片尺寸
- (UIImage*)kj_zoomImageWithMaxSize:(CGSize)size{
    float imgHeight = self.size.height;
    float imgWidth  = self.size.width;
    float maxHeight = size.width;
    float maxWidth = size.height;
    float imgRatio = imgWidth/imgHeight;
    float maxRatio = maxWidth/maxHeight;
    if (imgHeight <= maxHeight && imgWidth <= maxWidth) return self;
    if (imgHeight > maxHeight || imgWidth > maxWidth) {
        if(imgRatio < maxRatio) {
            imgRatio = maxHeight / imgHeight;
            imgWidth = imgRatio * imgWidth;
            imgHeight = maxHeight;
        }else if(imgRatio > maxRatio) {
            imgRatio = maxWidth / imgWidth;
            imgHeight = imgRatio * imgHeight;
            imgWidth = maxWidth;
        }else {
            imgHeight = maxHeight;
            imgWidth = maxWidth;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, imgWidth, imgHeight);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (UIImage*)kj_scaleWithFixedWidth:(CGFloat)width {
    float newHeight = self.size.height * (width / self.size.width);
    CGSize size = CGSizeMake(width, newHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}
- (UIImage*)kj_scaleWithFixedHeight:(CGFloat)height {
    float newWidth = self.size.width * (height / self.size.height);
    CGSize size = CGSizeMake(newWidth, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}
/// 通过比例来缩放图片
- (UIImage *)kj_scaleImage:(CGFloat)scale{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (UIImage*)kj_maskImage:(UIImage*)image MaskImage:(UIImage*)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef sourceImage = [image CGImage];
    CGImageRef imageWithAlpha = sourceImage;
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
//        imageWithAlpha = CopyImageAndAddAlphaChannel(sourceImage);
    }
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    if (sourceImage != imageWithAlpha) CGImageRelease(imageWithAlpha);
    UIImage * retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return retImage;
}
/// 不拉升填充图片
- (UIImage*)kj_fitImageWithSize:(CGSize)size{
    CGFloat x,y,w,h;
    if ((self.size.width/self.size.height)<(size.width/size.height)) {
        y = 0.;
        h = size.height;
        w = self.size.width * h / self.size.height;
        x = (size.width - w) / 2.;
    }else {
        x = 0.;
        w = size.width;
        h = self.size.height * w / self.size.width;
        y = -(size.height - h) / 2.;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, h);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(x, y, w, h), self.CGImage);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}
@end
