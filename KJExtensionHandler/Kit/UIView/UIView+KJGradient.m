//
//  UIView+KJGradient.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/22.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "UIView+KJGradient.h"

@implementation UIView (KJGradient)
#pragma mark - 渐变相关
- (CAGradientLayer *)kj_GradientLayerWithColors:(NSArray *)colors Frame:(CGRect)frm Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (colors == nil || [colors isKindOfClass:[NSNull class]] || colors.count == 0){
        return nil;
    }
    if (locations == nil || [locations isKindOfClass:[NSNull class]] || locations.count == 0){
        return nil;
    }
    NSMutableArray *colorsTemp = [NSMutableArray new];
    for (UIColor *color in colors) {
        if ([color isKindOfClass:[UIColor class]]) {
            [colorsTemp addObject:(__bridge id)color.CGColor];
        }
    }
    gradientLayer.colors = colorsTemp;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame =  frm;
    return gradientLayer;
}

- (void)kj_GradientBgColorWithColors:(NSArray *)colors Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [self kj_GradientLayerWithColors:colors Frame:self.bounds Locations:locations StartPoint:startPoint EndPoint:endPoint];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

//虚线边框
- (void)kj_DashedLineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth spaceAry:(NSArray<NSNumber *> *)spaceAry {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    if (self.layer.cornerRadius>0) {/// 带圆角
        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    }else{
        borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    }
    borderLayer.lineWidth = lineWidth / [UIScreen mainScreen].scale;
    borderLayer.lineDashPattern = spaceAry;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

@end
