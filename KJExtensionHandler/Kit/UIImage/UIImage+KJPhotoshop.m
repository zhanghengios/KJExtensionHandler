//
//  UIImage+KJPhotoshop.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/5/7.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIImage+KJPhotoshop.h"

@implementation UIImage (KJPhotoshop)
/// 获取图片平均颜色
- (UIColor*)kj_getImageAverageColor{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba,1,1,8,4,colorSpace,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0,0,1,1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat mu = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*mu green:((CGFloat)rgba[1])*mu blue:((CGFloat)rgba[2])*mu alpha:alpha];
    }else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0 green:((CGFloat)rgba[1])/255.0 blue:((CGFloat)rgba[2])/255.0 alpha:((CGFloat)rgba[3])/255.0];
    }
}
/// 改变图片透明度
- (UIImage*)kj_changeImageAlpha:(CGFloat)alpha{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/// 改变图片颜色
- (UIImage*)kj_changeImageColor:(UIColor*)color{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width*2, self.size.height*2));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width * 2, self.size.height * 2);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, self.CGImage);
    [color set];
    CGContextFillRect(ctx, area);
    CGContextRestoreGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
/// 获得灰度图
- (UIImage*)kj_getGrayImage{
    //根据设备的屏幕缩放比例调整生成图片的尺寸，避免在图片变糊
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat w = self.size.width * scale;
    CGFloat h = self.size.height * scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    //使用kCGImageAlphaPremultipliedLast保留Alpha通道，避免透明区域变成黑色
    CGContextRef context = CGBitmapContextCreate(nil,w,h,8,0,colorSpace,kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context,CGRectMake(0,0,w,h),[self CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    return newImage;
}

@end
