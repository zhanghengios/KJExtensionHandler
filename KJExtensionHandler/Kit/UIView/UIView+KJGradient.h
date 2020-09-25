//
//  UIView+KJGradient.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/22.
//  Copyright © 2020 杨科军. All rights reserved.
//  渐变处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJGradient)
/**
 返回渐变layer
 @param colors     渐变的颜色
 @param locations  渐变颜色的分割点
 @param startPoint 渐变颜色的方向起点,范围在（0,0）与（1,1）之间,如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param endPoint   渐变颜色的方向终点
 */
- (CAGradientLayer *)kj_GradientLayerWithColors:(NSArray *)colors Frame:(CGRect)frm Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint;

/**
 生成渐变背景色
 @param colors     渐变的颜色
 @param locations  渐变颜色的分割点
 @param startPoint 渐变颜色的方向起点,范围在（0，0）与（1,1）之间,如(0,0)(1,0)代表水平方向渐变,(0,0)(0,1)代表竖直方向渐变
 @param endPoint   渐变颜色的方向终点
 */
- (void)kj_GradientBgColorWithColors:(NSArray *)colors Locations:(NSArray *)locations StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint;

/** 虚线边框
 @param lineColor 线条颜色
 @param lineWidth 线宽
 @param spaceAry  线条之间间隔数组
 */
- (void)kj_DashedLineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth spaceAry:(NSArray<NSNumber *> *)spaceAry;

@end

NS_ASSUME_NONNULL_END
