//
//  UIButton+KJCreate.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJCreate.h"

@implementation UIButton (KJCreate)
/// 创建图片按钮
+ (instancetype)kj_createButtonWithImageName:(NSString*)imageName{
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = UIColor.clearColor;
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}
+ (instancetype)kj_createButtonWithImageName:(NSString*)imageName SelectImageName:(NSString*)imageName2{
    UIButton * button = [self kj_createButtonWithImageName:imageName];
    [button setImage:[UIImage imageNamed:imageName2] forState:UIControlStateSelected];
    return button;
}

/// 创建文本按钮
+ (instancetype)kj_createButtonWithFontSize:(CGFloat)fontSize Title:(NSString*)title TextColor:(UIColor*)color{
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = UIColor.clearColor;
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return button;
}
+ (instancetype)kj_createButtonWithFontSize:(CGFloat)fontSize Title:(NSString*)title TextColor:(UIColor*)color SelectTitle:(NSString*)title2 SelectTextColor:(UIColor*)color2{
    UIButton * button = [self kj_createButtonWithFontSize:fontSize Title:title TextColor:color];
    [button setTitle:title2 forState:UIControlStateSelected];
    [button setTitleColor:color2 forState:UIControlStateSelected];
    return button;
}

/// 创建图文按钮
+ (instancetype)kj_createButtonWithImageName:(NSString*)imageName Title:(NSString*)title FontSize:(CGFloat)fontSize TextColor:(UIColor*)color{
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = UIColor.clearColor;
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

@end
