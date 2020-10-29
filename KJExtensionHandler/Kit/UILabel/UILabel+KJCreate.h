//
//  UILabel+KJCreate.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  快速创建文本

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KJCreate)

/// 默认字号14，黑色，居中
+ (instancetype)kj_createLabelWithText:(NSString*)text;
+ (instancetype)kj_createLabelWithText:(NSString*)text FontSize:(CGFloat)fontSize;
+ (instancetype)kj_createLabelWithText:(NSString*)text FontSize:(CGFloat)fontSize TextColor:(UIColor*)color;
+ (instancetype)kj_createLabelWithText:(NSString*)text FontSize:(CGFloat)fontSize TextColor:(UIColor*)color Alignment:(NSTextAlignment)alignment;

@end

NS_ASSUME_NONNULL_END
