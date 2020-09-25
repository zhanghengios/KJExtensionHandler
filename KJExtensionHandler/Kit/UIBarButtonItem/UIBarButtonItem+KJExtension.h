//
//  UIBarButtonItem+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (KJExtension)
/** 快速创建一个 UIBarButtonItem
 *  @param image     普通状态下的图片
 *  @param highImage 高亮状态下的图片
 *  @param title     名字
 *  @param target    目标
 *  @param action    操作
 */
+ (instancetype)kj_ItemWithImage:(NSString *)image HighImage:(NSString *)highImage Title:(NSString *)title TitleColor:(UIColor *)titleColor Target:(id)target Action:(SEL)action;

+ (instancetype)leftItemWithImage:(NSString*)image higthImage:(NSString*)hightImage title:(NSString*)title target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
