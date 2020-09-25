//
//  UIImage+KJMask.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/25.
//  Copyright © 2020 杨科军. All rights reserved.
//  蒙版处理

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJMask)
/// 圆形图片
- (UIImage*)kj_circleImage;
/// 图片添加水印
- (UIImage*)kj_waterMark:(UIImage*)mark InRect:(CGRect)rect;
/// 拼接图片
- (UIImage*)kj_jointImageWithHeadImage:(UIImage*)headImage FootImage:(UIImage*)footImage;
/// 图片多次合成处理
- (UIImage*)kj_imageCompoundWithLoopNums:(NSInteger)loopTimes Orientation:(UIImageOrientation)orientation;
/// 蒙版图片处理
- (UIImage*)kj_maskImage:(UIImage*)maskImage;
/// 图片透明区域点击穿透处理
- (bool)kj_transparentWithPoint:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
