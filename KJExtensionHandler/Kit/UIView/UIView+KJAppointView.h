//
//  UIView+KJAppointView.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/6.
//  Copyright © 2019 杨科军. All rights reserved.
//  一些指定图形

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJAppointView)
/// 画直线
- (void)kj_DrawLineWithPoint:(CGPoint)fPoint toPoint:(CGPoint)tPoint lineColor:(UIColor *)color lineWidth:(CGFloat)width;

/// 画虚线
- (void)kj_DrawDashLineWithPoint:(CGPoint)fPoint toPoint:(CGPoint)tPoint lineColor:(UIColor *)color lineWidth:(CGFloat)width lineSpace:(CGFloat)space lineType:(NSInteger)type;

/// 画五角星
- (void)kj_DrawPentagramWithCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color rate:(CGFloat)rate;

// 根据宽高画六边形
- (void)kj_DrawSexangleWithWidth:(CGFloat)width LineWidth:(CGFloat)lineWidth StrokeColor:(UIColor *)color FillColor:(UIColor *)fcolor;

// 根据宽高画八边形   px:放大px点个坐标  py:放大py点个坐标
- (void)kj_DrawOctagonWithWidth:(CGFloat)width Height:(CGFloat)height LineWidth:(CGFloat)lineWidth StrokeColor:(UIColor *)color FillColor:(UIColor *)fcolor Px:(CGFloat)px Py:(CGFloat)py;

@end

NS_ASSUME_NONNULL_END
