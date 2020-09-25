//
//  UIBarButtonItem+KJExtension.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "UIBarButtonItem+KJExtension.h"
#import "UIView+KJFrame.h"

@implementation UIBarButtonItem (KJExtension)

+ (instancetype)kj_ItemWithImage:(NSString *)image HighImage:(NSString *)highImage Title:(NSString *)title TitleColor:(UIColor *)titleColor Target:(id)target Action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    if (!titleColor){ [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];}
    else{ [button setTitleColor:titleColor forState:UIControlStateNormal];}
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.size = button.currentBackgroundImage.size;
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)leftItemWithImage:(NSString*)image higthImage:(NSString*)hightImage title:(NSString*)title target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    // 让按钮根据图片和文字的宽自适应
    // [button sizeToFit];
    button.size = CGSizeMake(50, 30);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 微调button在导航条上的位置
    //    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
