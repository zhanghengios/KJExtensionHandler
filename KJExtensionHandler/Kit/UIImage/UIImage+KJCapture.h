//
//  UIImage+KJCapture.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/25.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  截图和裁剪处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJCapture)
#pragma mark - 截图处理
/// 当前视图截图
+ (UIImage*)kj_captureScreen:(UIView*)view;
/// 指定位置屏幕截图
+ (UIImage*)kj_captureScreen:(UIView*)view Rect:(CGRect)rect;
/// 截取当前屏幕（窗口截图）
+ (UIImage*)kj_captureScreenWindow;
/// 截取当前屏幕（根据手机方向旋转）
+ (UIImage*)kj_captureScreenWindowForInterfaceOrientation;
/// 截取滚动视图的长图
+ (UIImage*)kj_captureScreenWithScrollView:(UIScrollView*)scroll ContentOffset:(CGPoint)contentOffset;

#pragma mark - 裁剪处理
/// 裁剪掉图片周围的透明部分
+ (UIImage*)kj_cutImageRoundAlphaZero:(UIImage*)image;
/// 不规则图形切图
+ (UIImage*)kj_anomalyCaptureImageWithView:(UIView*)view BezierPath:(UIBezierPath*)path;
/// 多边形切图
+ (UIImage*)kj_polygonCaptureImageWithImageView:(UIImageView*)imageView PointArray:(NSArray*)points;
/// 指定区域裁剪
+ (UIImage*)kj_cutImageWithImage:(UIImage*)image Frame:(CGRect)cropRect;
/// quartz 2d 实现裁剪
+ (UIImage*)kj_quartzCutImageWithImage:(UIImage*)image Frame:(CGRect)cropRect;
/// 图片路径裁剪，裁剪路径 "以外" 部分
+ (UIImage*)kj_captureOuterImage:(UIImage*)image BezierPath:(UIBezierPath*)path Rect:(CGRect)rect;
/// 图片路径裁剪，裁剪路径 "以内" 部分
+ (UIImage*)kj_captureInnerImage:(UIImage*)image BezierPath:(UIBezierPath*)path Rect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
