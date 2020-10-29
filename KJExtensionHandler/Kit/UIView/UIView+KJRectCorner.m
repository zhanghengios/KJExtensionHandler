//
//  UIView+KJRectCorner.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIView+KJRectCorner.h"
#import <objc/runtime.h>

static NSString * const kcornerRadius = @"kj_rectCornerRadius";
static NSString * const krectCorner = @"kj_rectCorner";
@implementation UIView (KJRectCorner)
- (void)setKj_radius:(CGFloat)kj_radius{
    CGFloat r = [objc_getAssociatedObject(self, &kcornerRadius) floatValue];
    if (r != kj_radius) {
        [self willChangeValueForKey:kcornerRadius];
        objc_setAssociatedObject(self, &kcornerRadius, @(kj_radius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:kcornerRadius];
        [self kj_rectCornerWithCornerRadius:kj_radius Corner:self.kj_rectCorner];
    }
}
- (CGFloat)kj_radius{
    if (!objc_getAssociatedObject(self, &kcornerRadius)) [self setKj_radius:5];
    return [objc_getAssociatedObject(self, &kcornerRadius) floatValue];
}
- (void)setKj_rectCorner:(UIRectCorner)kj_rectCorner{
    [self willChangeValueForKey:krectCorner];
    objc_setAssociatedObject(self, &krectCorner, @(kj_rectCorner), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:krectCorner];
    [self kj_rectCornerWithCornerRadius:self.kj_radius Corner:kj_rectCorner];
}
- (UIRectCorner)kj_rectCorner{
    return [objc_getAssociatedObject(self, &krectCorner) intValue];
}
/// 内部方法
- (void)kj_rectCornerWithCornerRadius:(CGFloat)cornerRadius Corner:(UIRectCorner)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - 边框相关
- (UIColor*)kj_borderColor{
    if (!objc_getAssociatedObject(self, @selector(kj_borderColor))) [self setKj_borderColor:UIColor.blackColor];
    return objc_getAssociatedObject(self, @selector(kj_borderColor));
}
- (void)setKj_borderColor:(UIColor*)kj_borderColor{
    objc_setAssociatedObject(self, @selector(kj_borderColor), kj_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)kj_borderWidth{
    if (!objc_getAssociatedObject(self, @selector(kj_borderWidth))) [self setKj_borderWidth:1.];
    return [objc_getAssociatedObject(self, @selector(kj_borderWidth)) floatValue];
}
- (void)setKj_borderWidth:(CGFloat)kj_borderWidth{
    objc_setAssociatedObject(self, @selector(kj_borderWidth), @(kj_borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (bool)kj_borderTop{
    return [objc_getAssociatedObject(self, @selector(kj_borderTop)) intValue];
}
- (void)setKj_borderTop:(bool)kj_borderTop{
    if (kj_borderTop) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, self.kj_borderWidth);
        layer.backgroundColor = self.kj_borderColor.CGColor;
        [self.layer addSublayer:layer];
    }
    objc_setAssociatedObject(self, @selector(kj_borderTop), @(kj_borderTop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (bool)kj_borderBottom{
    return [objc_getAssociatedObject(self, @selector(kj_borderBottom)) intValue];
}
- (void)setKj_borderBottom:(bool)kj_borderBottom{
    if (kj_borderBottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.kj_borderWidth, self.frame.size.height);
        layer.backgroundColor = self.kj_borderColor.CGColor;
        [self.layer addSublayer:layer];
    }
    objc_setAssociatedObject(self, @selector(kj_borderBottom), @(kj_borderBottom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (bool)kj_borderLeft{
    return [objc_getAssociatedObject(self, @selector(kj_borderLeft)) intValue];
}
- (void)setKj_borderLeft:(bool)kj_borderLeft{
    if (kj_borderLeft) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - self.kj_borderWidth, self.frame.size.width, self.kj_borderWidth);
        layer.backgroundColor = self.kj_borderColor.CGColor;
        [self.layer addSublayer:layer];
    }
    objc_setAssociatedObject(self, @selector(kj_borderLeft), @(kj_borderLeft), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (bool)kj_borderRight{
    return [objc_getAssociatedObject(self, @selector(kj_borderRight)) intValue];
}
- (void)setKj_borderRight:(bool)kj_borderRight{
    if (kj_borderRight) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - self.kj_borderWidth, 0, self.kj_borderWidth, self.frame.size.height);
        layer.backgroundColor = self.kj_borderColor.CGColor;
        [self.layer addSublayer:layer];
    }
    objc_setAssociatedObject(self, @selector(kj_borderRight), @(kj_borderRight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)kj_movingShadow{
    static float step = 0.0;
    if (step>20.0) step = 0.0;
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 1.5;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint p1 = CGPointMake(0.0, 0.0+self.frame.size.height);
    CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
    CGPoint c1 = CGPointMake((p1.x+p2.x)/4 , p1.y+step);
    CGPoint c2 = CGPointMake(c1.x*3, c1.y);
    [path moveToPoint:p1];
    [path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    self.layer.shadowPath = path.CGPath;
    step += 0.1;
    [self performSelector:@selector(kj_movingShadow) withObject:nil afterDelay:1.0/30.0];
}


@end
