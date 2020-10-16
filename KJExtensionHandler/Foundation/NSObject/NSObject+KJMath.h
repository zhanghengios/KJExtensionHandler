//
//  NSObject+KJMath.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  数学算法方程式

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

struct KJMathPoint {
    CGFloat x;
    CGFloat y;
};typedef struct KJMathPoint KJMathPoint;
static inline KJMathPoint KJMathPointMake(CGFloat x, CGFloat y) {
    KJMathPoint p; p.x = x; p.y = y; return p;
}
@interface NSObject (KJMath)
/// 把弧度转换成角度
+ (CGFloat)kj_degreeFromRadian:(CGFloat)radian;
/// 把度转换成弧度
+ (CGFloat)kj_radianFromDegree:(CGFloat)degree;
/// 从数学 tan 函数的弧度值
+ (CGFloat)kj_radianValueFromTanSideA:(CGFloat)sideA sideB:(CGFloat)sideB;
/// 获取具有固定宽度的新size
+ (CGSize)kj_resetFromSize:(CGSize)size FixedWidth:(CGFloat)width;
/// 获取具有固定高度的新size
+ (CGSize)kj_resetFromSize:(CGSize)size FixedHeight:(CGFloat)height;

#pragma mark - 一元一次线性方程 (Y = kX + b).
@property (nonatomic,assign,class) CGFloat kj_k;
@property (nonatomic,assign,class) CGFloat kj_b;
/// 一元一次线性方程，求k，b
+ (void)kj_mathOnceLinearEquationWithPointA:(KJMathPoint)pointA PointB:(KJMathPoint)pointB;
/// 已知y，k，b 求 x
+ (CGFloat)kj_xValueWithY:(CGFloat)yValue;
/// 已知x，k，b 求 y
+ (CGFloat)kj_yValueWithX:(CGFloat)xValue;

@end

NS_ASSUME_NONNULL_END
