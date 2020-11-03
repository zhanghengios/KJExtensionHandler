//
//  UIImage+KJCoreImage.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIImage+KJCoreImage.h"

@implementation UIImage (KJCoreImage)
- (EAGLContext*)eagContext{
    EAGLContext *eag = objc_getAssociatedObject(self, @selector(eagContext));
    if (eag == nil) {
        // 创建基于GPU的CIContext对象，处理速度更快，实时渲染
        eag = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        objc_setAssociatedObject(self, @selector(eagContext), eag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return eag;
}
- (CIContext*)ciContext{
    CIContext *context = objc_getAssociatedObject(self, @selector(ciContext));
    if (context == nil) {
        context = [CIContext contextWithEAGLContext:self.eagContext options:@{kCIContextWorkingColorSpace:[NSNull null]}];
        objc_setAssociatedObject(self, @selector(ciContext), context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return context;
}
/// Photoshop滤镜相关操作
- (UIImage*)kj_coreImagePhotoshopWithType:(KJCoreImagePhotoshopType)type Value:(CGFloat)value{
    CIImage *cimg = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:KJImageFilterTypeStringMap[type] keysAndValues:kCIInputImageKey,cimg,nil];
    [filter setValue:@(value) forKey:KJCoreImagePhotoshopTypeStringMap[type]];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [self.ciContext createCGImage:result fromRect:[cimg extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
}
/// 通用方法 - 传入过滤器名称和需要的参数
- (UIImage*)kj_coreImageCustomWithName:(NSString*_Nonnull)name Dicts:(NSDictionary*_Nullable)dicts{
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:name keysAndValues:kCIInputImageKey,ciImage,nil];
    for (NSString *key in dicts.allKeys) {
        [filter setValue:dicts[key] forKey:key];
    }
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [self.ciContext createCGImage:result fromRect:[ciImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
}
/// 调整图像的色调映射，同时保留空间细节（高光和阴影）
- (UIImage*)kj_coreImageHighlightShadowWithHighlightAmount:(CGFloat)HighlightAmount ShadowAmount:(CGFloat)ShadowAmount{
    NSDictionary *dict = @{@"inputHighlightAmount":@(HighlightAmount),
                           @"inputShadowAmount":@(ShadowAmount)};
    return [self kj_coreImageCustomWithName:@"CIHighlightShadowAdjust" Dicts:dict];
}
/// 将灰度图像转换为被alpha遮罩的白色图像，源图像中的白色值将生成蒙版的内部；黑色值变得完全透明
- (UIImage*)kj_coreImageBlackMaskToAlpha{
    return [self kj_coreImageCustomWithName:@"CIMaskToAlpha" Dicts:nil];
}
/// 马赛克
- (UIImage*)kj_coreImagePixellateWithCenter:(CGPoint)center Scale:(CGFloat)scale{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputScale":@(scale)};
    return [self kj_coreImageCustomWithName:@"CIPixellate" Dicts:dict];
}
/// 图片圆形变形
- (UIImage*)kj_coreImageCircularWrapWithCenter:(CGPoint)center Radius:(CGFloat)radius Angle:(CGFloat)angle{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputRadius":@(radius),
                           @"inputAngle":@(angle)};
    return [self kj_coreImageCustomWithName:@"CICircularWrap" Dicts:dict];
}
/// 环形透镜畸变
- (UIImage*)kj_coreImageTorusLensDistortionCenter:(CGPoint)center Radius:(CGFloat)radius Width:(CGFloat)width Refraction:(CGFloat)refraction{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputRadius":@(radius),
                           @"inputWidth":@(width),
                           @"inputRefraction":@(refraction)};
    return [self kj_coreImageCustomWithName:@"CITorusLensDistortion" Dicts:dict];
}
/// 空变形
- (UIImage*)kj_coreImageHoleDistortionCenter:(CGPoint)center Radius:(CGFloat)radius{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputRadius":@(radius)};
    return [self kj_coreImageCustomWithName:@"CIHoleDistortion" Dicts:dict];
}
/// 应用透视校正，将源图像中的任意四边形区域转换为矩形输出图像
- (UIImage*)kj_coreImagePerspectiveCorrectionWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    return [self kj_PerspectiveTransformAndPerspectiveCorrection:@"CIPerspectiveCorrection" TopLeft:TopLeft TopRight:TopRight BottomRight:BottomRight BottomLeft:BottomLeft];
}
/// 透视变换，透视滤镜倾斜图像
- (UIImage*)kj_coreImagePerspectiveTransformWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    return [self kj_PerspectiveTransformAndPerspectiveCorrection:@"CIPerspectiveTransform" TopLeft:TopLeft TopRight:TopRight BottomRight:BottomRight BottomLeft:BottomLeft];
}
/// 软装专属透视 - 内部有相对应的坐标转换
- (UIImage*)kj_softFitmentFluoroscopyWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    NSArray *temp = @[NSStringFromCGPoint(TopLeft),
                      NSStringFromCGPoint(TopRight),
                      NSStringFromCGPoint(BottomRight),
                      NSStringFromCGPoint(BottomLeft)];
    CGFloat minY = TopLeft.y,maxY = TopLeft.y;
    CGPoint pt = CGPointZero;
    for (NSString *string in temp) {
        pt = CGPointFromString(string);
        minY = pt.y < minY ? pt.y : minY;
        maxY = pt.y > maxY ? pt.y : maxY;
    }
    CGFloat H = maxY - minY;
    /// 水平方向上下镜像
    TopLeft.y     = -(TopLeft.y + H);
    BottomLeft.y  = -(BottomLeft.y + H);
    BottomRight.y = -(BottomRight.y + H);
    TopRight.y    = -(TopRight.y + H);
    return [self kj_PerspectiveTransformAndPerspectiveCorrection:@"CIPerspectiveTransform" TopLeft:TopLeft TopRight:TopRight BottomRight:BottomRight BottomLeft:BottomLeft];
}
/// 透视相关方法
- (UIImage*)kj_PerspectiveTransformAndPerspectiveCorrection:(NSString*)name TopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:name keysAndValues:kCIInputImageKey, ciImage, nil];
    CIVector *vector1 = [CIVector vectorWithX:TopLeft.x Y:TopLeft.y];
    CIVector *vector2 = [CIVector vectorWithX:TopRight.x Y:TopRight.y];
    CIVector *vector3 = [CIVector vectorWithX:BottomRight.x Y:BottomRight.y];
    CIVector *vector4 = [CIVector vectorWithX:BottomLeft.x Y:BottomLeft.y];
    [filter setValue:vector1 forKey:@"inputTopLeft"];
    [filter setValue:vector2 forKey:@"inputTopRight"];
    [filter setValue:vector3 forKey:@"inputBottomRight"];
    [filter setValue:vector4 forKey:@"inputBottomLeft"];
    /// 输出图片
    CIImage *outputImage = [filter outputImage];
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    return newImage;
}
/*
将定向聚光灯效果应用于图像（射灯）
LightPosition：光源位置（三维坐标）
LightPointsAt：光点（三维坐标）
Brightness：亮度
Concentration：聚光灯聚焦的紧密程度 0 ～ 1
Color：聚光灯的颜色
*/
- (UIImage*)kj_coreImageSpotLightWithLightPosition:(CIVector*)lightPosition LightPointsAt:(CIVector*)lightPointsAt Brightness:(CGFloat)brightness Concentration:(CGFloat)concentration LightColor:(UIColor*)color{
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CISpotLight" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
//    [filter setValue:lightPosition forKey:@"inputLightPosition"];
    [filter setValue:lightPointsAt forKey:@"inputLightPointsAt"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];
    [filter setValue:@(concentration) forKey:@"inputConcentration"];
    CIColor *inputColor = [[CIColor alloc] initWithColor:color];
    [filter setValue:inputColor forKey:@"inputColor"];
    
    CIImage *outputImage = [filter outputImage];
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    return newImage;
}

@end
