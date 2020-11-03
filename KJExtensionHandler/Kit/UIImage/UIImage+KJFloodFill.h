//
//  UIImage+FloodFill.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  基于扫描线的泛洪算法，获取填充同颜色区域后的图片

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJFloodFill)

/* 基于扫描线的泛洪算法，获取填充同颜色区域后的图片
 @param startPoint 相对于图片的起点
 @param newColor   填充的颜色
 @param tolerance  判断相邻颜色相同的容差值
 @param antialias  是否抗锯齿化
 @return           填充后的图片
 */
- (UIImage *)kj_FloodFillImageFromStartPoint:(CGPoint)startPoint
                                    NewColor:(UIColor*)newColor
                                   Tolerance:(CGFloat)tolerance
                                UseAntialias:(BOOL)antialias;

/* 泛洪算法通常有3种实现,四邻域，八邻域和基于扫描线
 * 了解更多泛洪算法可以查看下列链接：https://lodev.org/cgtutor/floodfill.html
 */

@end

NS_ASSUME_NONNULL_END
