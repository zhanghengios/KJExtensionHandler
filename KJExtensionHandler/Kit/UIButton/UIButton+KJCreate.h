//
//  UIButton+KJCreate.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  按钮快速创建

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJCreate)
/// 创建图片按钮
+ (instancetype)kj_createButtonWithImageName:(NSString*)imageName;
+ (instancetype)kj_createButtonWithImageName:(NSString*)imageName SelectImageName:(NSString*)imageName2;

/// 创建文本按钮
+ (instancetype)kj_createButtonWithFontSize:(CGFloat)fontSize Title:(NSString*)title TextColor:(UIColor*)color;
+ (instancetype)kj_createButtonWithFontSize:(CGFloat)fontSize Title:(NSString*)title TextColor:(UIColor*)color SelectTitle:(NSString*)title2 SelectTextColor:(UIColor*)color2;

/// 创建图文按钮
+ (instancetype)kj_createButtonWithImageName:(NSString*)imageName Title:(NSString*)title FontSize:(CGFloat)fontSize TextColor:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
