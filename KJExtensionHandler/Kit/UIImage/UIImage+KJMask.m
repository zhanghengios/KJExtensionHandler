//
//  UIImage+KJMask.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/25.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "UIImage+KJMask.h"

@implementation UIImage (KJMask)
/// 圆形图片
- (UIImage *)kj_circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
// 画水印
- (UIImage*)kj_waterMark:(UIImage*)mark InRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGRect imgRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:imgRect];
    [mark drawInRect:rect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}
/* Image 拼接
 * headImage   头图片
 * footImage   尾图片
 */
- (UIImage *)kj_jointImageWithHeadImage:(UIImage *)headImage FootImage:(UIImage *)footImage{
    CGSize size = CGSizeZero;
    size.width = self.size.width;
    CGFloat headHeight = !headImage ? 0 : headImage.size.height;
    CGFloat footHeight = !footImage ? 0 : footImage.size.height;
    size.height = self.size.height + headHeight + footHeight;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    if (headImage) [headImage drawInRect:CGRectMake(0, 0, self.size.width, headHeight)];
    [self drawInRect:CGRectMake(0, headHeight, self.size.width, self.size.height)];
    if (footImage) [footImage drawInRect:CGRectMake(0, self.size.height + headHeight, self.size.width, footHeight)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
/**把图片多次合成
 @param loopNums   要合成的次数
 @param orientation 当前的方向
 @return 合成完成的图片
 */
- (UIImage *)kj_imageCompoundWithLoopNums:(NSInteger)loopNums Orientation:(UIImageOrientation)orientation{
    UIGraphicsBeginImageContextWithOptions(self.size ,NO, 0.0);
    switch (orientation) {
        case UIImageOrientationUp:
            for (int i = 0; i < loopNums; i ++){
                CGFloat X = self.size.width/loopNums*i;
                CGFloat Y = 0;
                CGFloat W = self.size.width/loopNums;
                CGFloat H = self.size.height;
                [self drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        case UIImageOrientationLeft :
            for (int i = 0; i < loopNums; i ++){
                CGFloat X = 0;
                CGFloat Y = self.size.height / loopNums * i;
                CGFloat W = self.size.width;
                CGFloat H = self.size.height / loopNums;
                [self drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        case UIImageOrientationRight:
            for (int i = 0; i < loopNums; i ++){
                CGFloat X = 0;
                CGFloat Y = self.size.height / loopNums * i;
                CGFloat W = self.size.width;
                CGFloat H = self.size.height / loopNums;
                [self drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        default:
            break;
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
/// 蒙版图片处理
- (UIImage*)kj_maskImage:(UIImage*)maskImage{
    UIImage *image = self;
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
/// 透明图片穿透
- (bool)kj_transparentWithPoint:(CGPoint)point{
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel,1,1,8,1,NULL,kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [self drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0f;
    return alpha < 0.01f;
}
@end
