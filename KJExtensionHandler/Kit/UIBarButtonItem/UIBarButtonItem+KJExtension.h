//
//  UIBarButtonItem+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (KJExtension)

+ (instancetype)kj_ItemWithImage:(NSString*)image HighImage:(NSString*)highImage Title:(NSString*)title TitleColor:(UIColor*)titleColor Target:(id)target Action:(SEL)action;

+ (instancetype)leftItemWithImage:(NSString*)image higthImage:(NSString*)hightImage title:(NSString*)title target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
