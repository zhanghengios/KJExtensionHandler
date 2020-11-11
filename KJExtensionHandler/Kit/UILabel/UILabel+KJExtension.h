//
//  UILabel+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  文本位置和尺寸获取

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Label 文本显示样式
typedef NS_ENUM(NSUInteger, KJLabelTextAlignmentType) {
    KJLabelTextAlignmentTypeLeft = 0,
    KJLabelTextAlignmentTypeRight,
    KJLabelTextAlignmentTypeCenter,
    KJLabelTextAlignmentTypeLeftTop,
    KJLabelTextAlignmentTypeRightTop,
    KJLabelTextAlignmentTypeLeftBottom,
    KJLabelTextAlignmentTypeRightBottom,
    KJLabelTextAlignmentTypeTopCenter,
    KJLabelTextAlignmentTypeBottomCenter,
};
@interface UILabel (KJExtension)
/// 设置文字内容显示位置，外部不需要再去设置 " textAlignment " 属性
@property(nonatomic,assign)KJLabelTextAlignmentType kTextAlignmentType;
/// 获取高度
- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width;
/// 获取高度，指定行高
- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width OneLineHeight:(CGFloat)height;
/// 获取文字尺寸
+ (CGSize)kj_calculateLabelSizeWithTitle:(NSString*)title font:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

NS_ASSUME_NONNULL_END
