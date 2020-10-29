//
//  UILabel+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KJExtension)
/// 获取高度
- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width;
/// 获取高度，指定行高
- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width OneLineHeight:(CGFloat)height;
/// 获取文字尺寸
+ (CGSize)kj_calculateLabelSizeWithTitle:(NSString*)title font:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

NS_ASSUME_NONNULL_END
