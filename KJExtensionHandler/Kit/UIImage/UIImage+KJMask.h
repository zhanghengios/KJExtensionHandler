//
//  UIImage+KJMask.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/25.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  蒙版处理，图片拼接

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJMask)
/// 图片添加水印
- (UIImage*)kj_waterMark:(UIImage*)mark InRect:(CGRect)rect;
/// 蒙版图片处理
- (UIImage*)kj_maskImage:(UIImage*)maskImage;

#pragma mark - 其他
/// 圆形图片
- (UIImage*)kj_circleImage;
/// 图片透明区域点击穿透处理
- (bool)kj_transparentWithPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
