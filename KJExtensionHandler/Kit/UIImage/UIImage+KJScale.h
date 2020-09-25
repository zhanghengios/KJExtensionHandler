//
//  UIImage+KJScale.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  图片尺寸处理

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJScale)

#pragma mark - 图片尺寸处理
/// 改变Image的任何的大小
- (UIImage*)kj_cropImageWithAnySize:(CGSize)size;
/// 以固定宽度缩放图像
- (UIImage*)scaleWithFixedWidth:(CGFloat)width;
/// 以固定高度缩放图像
- (UIImage*)scaleWithFixedHeight:(CGFloat)height;
/// 裁剪和拉升图片
- (UIImage*)kj_scalingAndCroppingForTargetSize:(CGSize)targetSize;
/// 通过比例来缩放图片
- (UIImage*)kj_transformImageScale:(CGFloat)scale;
/// 不拉升填充图片
- (UIImage*)kj_scaleAspectFitImageWithSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
