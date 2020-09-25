//
//  NSObject+KJMath.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/31.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "NSObject+KJMath.h"

@implementation NSObject (KJMath)

+ (CGFloat)kj_degreeFromRadian:(CGFloat)radian {
    return ((radian) * (180.0 / M_PI));
}

+ (CGFloat)kj_radianFromDegree:(CGFloat)degree {
    return ((degree) * M_PI / 180.f);
}

+ (CGFloat)kj_radianValueFromTanSideA:(CGFloat)sideA sideB:(CGFloat)sideB {
    return atan2f(sideA, sideB);
}
+ (CGSize)kj_resetFromSize:(CGSize)size FixedWidth:(CGFloat)width {
    CGFloat newHeight = size.height * (width / size.width);
    CGSize  newSize   = CGSizeMake(width, newHeight);
    return newSize;
}

+ (CGSize)kj_resetFromSize:(CGSize)size FixedHeight:(CGFloat)height {
    float  newWidth = size.width * (height / size.height);
    CGSize newSize  = CGSizeMake(newWidth, height);
    return newSize;
}

#pragma mark - Calculate once linear equation (Y = kX + b)
+ (CGFloat)kj_k{
    return [objc_getAssociatedObject(self, @selector(kj_k)) floatValue];
}
+ (void)setKj_k:(CGFloat)kj_k{
    objc_setAssociatedObject(self, @selector(kj_k), @(kj_k), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (CGFloat)kj_b{
    return [objc_getAssociatedObject(self, @selector(kj_b)) floatValue];
}
+ (void)setKj_b:(CGFloat)kj_b{
    objc_setAssociatedObject(self, @selector(kj_b), @(kj_b), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)kj_mathOnceLinearEquationWithPointA:(KJMathPoint)pointA PointB:(KJMathPoint)pointB {
    CGFloat x1 = pointA.x; CGFloat y1 = pointA.y;
    CGFloat x2 = pointB.x; CGFloat y2 = pointB.y;
    self.kj_k = x1 == x2 ? 0 : (y2 - y1) / (x2 - x1);
    self.kj_b = x1 == x2 ? 0 : (y1*(x2 - x1) - x1*(y2 - y1)) / (x2 - x1);
}
+ (CGFloat)kj_xValueWithY:(CGFloat)yValue {
    if (self.kj_k == 0) return 0;
    return (yValue - self.kj_b) / self.kj_k;
}
+ (CGFloat)kj_yValueWithX:(CGFloat)xValue {
    return self.kj_k * xValue + self.kj_b;
}

@end
