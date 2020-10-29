//
//  UIColor+KJExtension.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIColor+KJExtension.h"

@implementation UIColor (KJExtension)
/// 渐变颜色
+ (UIColor*)zj_gradientColorWithColors:(NSArray*)colors GradientType:(KJGradietColorType)type Size:(CGSize)size{
    NSMutableArray *temps = [NSMutableArray array];
    for(UIColor *c in colors){
        [temps addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)temps, NULL);
    temps = nil;
    CGPoint start,end;
    switch (type) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case 3:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}
/// 渐变色
- (UIColor*)kj_gradientVerticalToColor:(UIColor*)color Height:(NSInteger)height{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    NSArray * colors = [NSArray arrayWithObjects:(id)self.CGColor, (id)color.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}
- (UIColor*)kj_gradientAcrossToColor:(UIColor*)color Width:(NSInteger)width{
    CGSize size = CGSizeMake(width, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    NSArray * colors = [NSArray arrayWithObjects:(id)self.CGColor, (id)color.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(size.width, size.height), 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}
// UIColor转#ffffff格式的16进制字符串
+ (NSString*)kj_hexStringFromColor:(UIColor*)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",lroundf(r*255),lroundf(g*255),lroundf(b*255)];
}
/// 16进制字符串转UIColor
+ (UIColor*)kj_colorWithHexString:(NSString*)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha,red,blue,green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue  = [self colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red   = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue  = [self colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue  = [self colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red   = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue  = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+ (CGFloat)colorComponentFrom:(NSString*)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start,length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@",substring,substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

/// 生成渐变色图片
+ (UIImage*)kj_colorImageWithColors:(NSArray<UIColor*>*)colors locations:(NSArray<NSNumber*>*)locations size:(CGSize)size borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    NSAssert(colors || locations, @"colors and locations must has value");
    NSAssert(colors.count == locations.count, @"Please make sure colors and locations count is equal");
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (borderWidth > 0 && borderColor) {
        CGRect rect = CGRectMake(size.width * 0.01, 0, size.width * 0.98, size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:size.height*0.5];
        [borderColor setFill];
        [path fill];
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(size.width * 0.01 + borderWidth, borderWidth, size.width * 0.98 - borderWidth * 2, size.height - borderWidth * 2) cornerRadius:size.height * 0.5];
    [self kj_drawLinearGradient:context path:path.CGPath colors:colors locations:locations];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (void)kj_drawLinearGradient:(CGContextRef)context path:(CGPathRef)path colors:(NSArray<UIColor*>*)colors locations:(NSArray<NSNumber*>*)locations{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSMutableArray *colorefs = [@[] mutableCopy];
    [colors enumerateObjectsUsingBlock:^(UIColor *obj, NSUInteger idx, BOOL *stop) {
        [colorefs addObject:(__bridge id)obj.CGColor];
    }];
    CGFloat locs[locations.count];
    for (int i = 0; i < locations.count; i++) {
        locs[i] = locations[i].floatValue;
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorefs, locs);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
/// 获取ImageView上指定点的图片颜色
+ (UIColor*)kj_colorAtImageView:(UIImageView*)imageView Point:(CGPoint)point{
    return [self kj_colorAtPixel:point Size:imageView.frame.size Image:imageView.image];
}
/// 获取图片上指定点的颜色
+ (UIColor*)kj_colorAtImage:(UIImage*)image Point:(CGPoint)point{
    return [self kj_colorAtPixel:point Size:image.size Image:image];
}
+ (UIColor*)kj_colorAtPixel:(CGPoint)point Size:(CGSize)size Image:(UIImage*)image{
    CGRect rect = CGRectMake(0,0,size.width,size.height);
    if (!CGRectContainsPoint(rect, point)) return nil;
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextTranslateCTM(context, -pointX, pointY - size.height);
    CGContextDrawImage(context, rect, cgImage);
    CGContextRelease(context);
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
