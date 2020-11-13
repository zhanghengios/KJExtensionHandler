//
//  UIView+KJGradient.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/22.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  渐变处理 和 指定图形

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJGradient)
/* 返回渐变layer
 @param colors     渐变的颜色
 @param locations  渐变颜色的分割点
 @param startPoint 渐变颜色的方向起点,范围在（0,0）与（1,1）之间,如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param endPoint   渐变颜色的方向终点
 */
- (CAGradientLayer*)kj_GradientLayerWithColors:(NSArray*)colors Frame:(CGRect)frm Locations:(NSArray*)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint;

/* 生成渐变背景色
 @param colors     渐变的颜色
 @param locations  渐变颜色的分割点
 @param startPoint 渐变颜色的方向起点,范围在（0，0）与（1,1）之间,如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param endPoint   渐变颜色的方向终点
 */
- (void)kj_GradientBgColorWithColors:(NSArray*)colors Locations:(NSArray*)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint;

/* 虚线边框
 @param lineColor 线条颜色
 @param lineWidth 线宽
 @param spaceAry  线条之间间隔数组
 */
- (void)kj_DashedLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth spaceAry:(NSArray<NSNumber*>*)spaceAry;

#pragma mark - 指定图形
/// 画直线
- (void)kj_DrawLineWithPoint:(CGPoint)fPoint toPoint:(CGPoint)tPoint lineColor:(UIColor*)color lineWidth:(CGFloat)width;
/// 画虚线
- (void)kj_DrawDashLineWithPoint:(CGPoint)fPoint toPoint:(CGPoint)tPoint lineColor:(UIColor*)color lineWidth:(CGFloat)width lineSpace:(CGFloat)space lineType:(NSInteger)type;
/// 画五角星
- (void)kj_DrawPentagramWithCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor*)color rate:(CGFloat)rate;
// 根据宽高画六边形
- (void)kj_DrawSexangleWithWidth:(CGFloat)width LineWidth:(CGFloat)lineWidth StrokeColor:(UIColor *)color FillColor:(UIColor*)fcolor;
// 根据宽高画八边形   px:放大px点个坐标  py:放大py点个坐标
- (void)kj_DrawOctagonWithWidth:(CGFloat)width Height:(CGFloat)height LineWidth:(CGFloat)lineWidth StrokeColor:(UIColor*)color FillColor:(UIColor*)fcolor Px:(CGFloat)px Py:(CGFloat)py;


@end

NS_ASSUME_NONNULL_END
