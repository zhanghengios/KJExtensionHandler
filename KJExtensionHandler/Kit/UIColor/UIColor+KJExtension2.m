//
//  UIColor+KJExtension2.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "UIColor+KJExtension2.h"

@implementation UIColor (KJExtension2)
- (CGFloat)red{
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}
- (CGFloat)green{
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}
- (CGFloat)blue{
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}
- (CGFloat)alpha{
    return CGColorGetAlpha(self.CGColor);
}
- (CGFloat)hue{
    KJColorHSL hsl = [self kj_colorGetHSL];
    return hsl.hue;
}
- (CGFloat)saturation{
    KJColorHSL hsl = [self kj_colorGetHSL];
    return hsl.saturation;
}
- (CGFloat)light{
    KJColorHSL hsl = [self kj_colorGetHSL];
    return hsl.light;
}
/// 获取颜色对应的RGBA
- (KJColorRGBA)kj_colorGetRGBA{
    KJColorRGBA rgba;
    NSString *colorString = [NSString stringWithFormat:@"%@",self];
    NSArray *temps = [colorString componentsSeparatedByString:@" "];
    rgba.red   = [temps[1] floatValue];
    rgba.green = [temps[2] floatValue];
    rgba.blue  = [temps[3] floatValue];
    rgba.alpha = [temps[4] floatValue];
    return rgba;
}
/// 获取颜色对应的色相饱和度和透明度
- (KJColorHSL)kj_colorGetHSL{
    CGFloat red,green,blue,alpha = 0.0f;
    BOOL success = [self getRed:&red green:&green blue:&blue alpha:&alpha];
    if (success == NO) return (KJColorHSL){0,0,0};
    CGFloat hue = 0;
    CGFloat saturation = 0;
    CGFloat light = 0;
    CGFloat min = MIN(red,MIN(green,blue));
    CGFloat max = MAX(red,MAX(green,blue));
    if (min==max) {
        hue = 0;
        saturation = 0;
        light = min;
    }else {
        CGFloat d = (red==min) ? green-blue : ((blue==min) ? red-green : blue-red);
        CGFloat h = (red==min) ? 3 : ((blue==min) ? 1 : 5);
        hue = (h - d / (max - min)) / 6.0;
        saturation = (max - min) / max;
        light = max;
    }
//    NSArray *array = @[[NSNumber numberWithInt:red],[NSNumber numberWithInt:green],[NSNumber numberWithInt:blue]];
//    max = [[array valueForKeyPath:@"@max.intValue"] intValue];
//    min = [[array valueForKeyPath:@"@min.intValue"] intValue];
//    if (red == max){
//        hue = (green - blue)/(max = min);
//    }else if(green == max){
//        hue = (blue - red)/(max = min);
//    }else if(blue == max){
//        hue = (red - green)/(max = min);
//    }
    hue = (2 * hue - 1) * M_PI;
    return (KJColorHSL){hue,saturation,light};
}
/// 获取颜色的均值
+ (UIColor*)kj_averageColors:(NSArray<UIColor*>*)colors{
    if (!colors || colors.count == 0)  return nil;
    CGFloat reds = 0.0f;
    CGFloat greens = 0.0f;
    CGFloat blues = 0.0f;
    CGFloat alphas = 0.0f;
    NSInteger count = 0;
    for (UIColor *c in colors) {
        CGFloat red = 0.0f;
        CGFloat green = 0.0f;
        CGFloat blue = 0.0f;
        CGFloat alpha = 0.0f;
        BOOL success = [c getRed:&red green:&green blue:&blue alpha:&alpha];
        if (success) {
            reds += red;
            greens += green;
            blues += blue;
            alphas += alpha;
            count++;
        }
    }
    return [UIColor colorWithRed:reds/count green:greens/count blue:blues/count alpha:alphas/count];
}
@end
