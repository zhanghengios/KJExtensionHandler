//
//  UIImage+KJPhotoshop.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/5/7.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJPhotoshop)
/// 获取图片平均颜色
- (UIColor*)kj_getImageAverageColor;
/// 改变图片透明度
- (UIImage*)kj_changeImageAlpha:(CGFloat)alpha;
/// 改变图片颜色
- (UIImage*)kj_changeImageColor:(UIColor*)color;
/// 获得灰度图
- (UIImage*)kj_getGrayImage;

@end

NS_ASSUME_NONNULL_END
