//
//  UIImage+KJCoreImage.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  CoreImage 框架整理
//  官网文档资料：https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAccordionFoldTransition

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <CoreImage/CoreImage.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJCoreImagePhotoshopType) {
    KJCoreImagePhotoshopTypeBrightnes, /// 亮度，-1 ～ 1   数越大越亮
    KJCoreImagePhotoshopTypeSaturation, /// 饱和度  0 ～ 2
    KJCoreImagePhotoshopTypeContrast, /// 对比度  0 ～ 4
    KJCoreImagePhotoshopTypeAngle, /// 色相，角度 -π ～ π
    KJCoreImagePhotoshopTypeExposure, /// 曝光度，
    KJCoreImagePhotoshopTypeSharpness, /// 锐化，0 ～ 100
    KJCoreImagePhotoshopTypePower, /// 伽玛调整（调整灰度系数可以有效地改变黑白之间的过渡斜率）0 ～ 1
    KJCoreImagePhotoshopTypeGaussianBlur, /// 高斯模糊，模糊半径 0 ～ 100
};
/// 滤镜过滤器
static NSString * const _Nonnull KJImageFilterTypeStringMap[] = {
    [KJCoreImagePhotoshopTypeBrightnes]  = @"CIColorControls", /// 色彩控制
    [KJCoreImagePhotoshopTypeSaturation] = @"CIColorControls",
    [KJCoreImagePhotoshopTypeContrast]   = @"CIColorControls",
    [KJCoreImagePhotoshopTypeAngle]      = @"CIHueAdjust", /// 色相滤镜
    [KJCoreImagePhotoshopTypeExposure]   = @"CIExposureAdjust",/// 曝光滤镜
    [KJCoreImagePhotoshopTypeSharpness]  = @"CISharpenLuminance",/// 细节锐化滤镜
    [KJCoreImagePhotoshopTypePower]      = @"CIGammaAdjust",/// 伽玛调整
    [KJCoreImagePhotoshopTypeGaussianBlur] = @"CIGaussianBlur",/// 高斯模糊
};
static NSString * const _Nonnull KJCoreImagePhotoshopTypeStringMap[] = {
    [KJCoreImagePhotoshopTypeBrightnes]  = @"inputBrightness",
    [KJCoreImagePhotoshopTypeSaturation] = @"inputSaturation",
    [KJCoreImagePhotoshopTypeContrast]   = @"inputContrast",
    [KJCoreImagePhotoshopTypeAngle]      = @"inputAngle", /// 该滤镜实质上使彩色立方体绕中性轴旋转
    [KJCoreImagePhotoshopTypeExposure]   = @"inputEV",
    [KJCoreImagePhotoshopTypeSharpness]  = @"inputSharpness",
    [KJCoreImagePhotoshopTypePower]      = @"inputPower",
    [KJCoreImagePhotoshopTypeGaussianBlur] = @"inputRadius",/// 高斯模糊
};
@interface UIImage (KJCoreImage)
/// Photoshop滤镜相关操作
- (UIImage*)kj_coreImagePhotoshopWithType:(KJCoreImagePhotoshopType)type Value:(CGFloat)value;

/// 通用方法 - 传入滤镜过滤器名称 和 需要的参数
- (UIImage*)kj_coreImageCustomWithName:(NSString*_Nonnull)name Dicts:(NSDictionary*_Nullable)dicts;

/// 调整图像的色调映射，同时保留空间细节（高光和阴影）
- (UIImage*)kj_coreImageHighlightShadowWithHighlightAmount:(CGFloat)HighlightAmount ShadowAmount:(CGFloat)ShadowAmount;

/// 将图片里面的黑色变透明
- (UIImage*)kj_coreImageBlackMaskToAlpha;

/// 马赛克
- (UIImage*)kj_coreImagePixellateWithCenter:(CGPoint)center Scale:(CGFloat)scale;

/// 图片圆形变形
- (UIImage*)kj_coreImageCircularWrapWithCenter:(CGPoint)center Radius:(CGFloat)radius Angle:(CGFloat)angle;

/// 环形透镜畸变
- (UIImage*)kj_coreImageTorusLensDistortionCenter:(CGPoint)center Radius:(CGFloat)radius Width:(CGFloat)width Refraction:(CGFloat)refraction;

/// 空变形
- (UIImage*)kj_coreImageHoleDistortionCenter:(CGPoint)center Radius:(CGFloat)radius;

/// 应用透视校正，将源图像中的任意四边形区域转换为矩形输出图像
- (UIImage*)kj_coreImagePerspectiveCorrectionWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft;

/// 透视变换，透视滤镜倾斜图像
- (UIImage*)kj_coreImagePerspectiveTransformWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft;

/// 软装专属透视 - 内部有相对应的坐标转换
- (UIImage*)kj_softFitmentFluoroscopyWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft;

/**
 将定向聚光灯效果应用于图像（射灯）
 LightPosition：光源位置（三维坐标）
 LightPointsAt：光点（三维坐标）
 Brightness：亮度
 Concentration：聚光灯聚焦的紧密程度 0 ～ 1
 Color：聚光灯的颜色
 */
- (UIImage*)kj_coreImageSpotLightWithLightPosition:(CIVector*)lightPosition LightPointsAt:(CIVector*)lightPointsAt Brightness:(CGFloat)brightness Concentration:(CGFloat)concentration LightColor:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
