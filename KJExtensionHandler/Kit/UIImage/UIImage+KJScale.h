//
//  UIImage+KJScale.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  图片尺寸处理

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJScale)
#pragma mark - 图片尺寸处理
/// 通过比例来缩放图片
- (UIImage*)kj_scaleImage:(CGFloat)scale;
/// 以固定宽度缩放图像
- (UIImage*)kj_scaleWithFixedWidth:(CGFloat)width;
/// 以固定高度缩放图像
- (UIImage*)kj_scaleWithFixedHeight:(CGFloat)height;
/// 等比改变图片尺寸
- (UIImage*)kj_cropImageWithAnySize:(CGSize)size;
/// 等比缩小图片尺寸
- (UIImage*)kj_zoomImageWithMaxSize:(CGSize)size;
/// 不拉升填充图片
- (UIImage*)kj_fitImageWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
