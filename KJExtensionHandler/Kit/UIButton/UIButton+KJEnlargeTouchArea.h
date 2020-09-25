//
//  UIButton+KJEnlargeTouchArea.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/5.
//  Copyright © 2019 杨科军. All rights reserved.
//  改变UIButton的响应区域 - 扩大Button点击域

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJEnlargeTouchArea)
/// 改变UIButton的响应区域 扩大点击域
- (void)kj_EnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;
/// 设置按钮额外热区 - 扩大按钮点击域
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

@end

NS_ASSUME_NONNULL_END
