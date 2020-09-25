//
//  UILabel+KJCreate.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "UILabel+KJCreate.h"

@implementation UILabel (KJCreate)
/// 默认字号14，黑色，居中
+ (instancetype)kj_createLabelWithText:(NSString*)text{
    return [self kj_createLabelWithText:text FontSize:14 TextColor:UIColor.blackColor Alignment:(NSTextAlignmentCenter)];
}
+ (instancetype)kj_createLabelWithText:(NSString*)text FontSize:(CGFloat)fontSize{
    return [self kj_createLabelWithText:text FontSize:fontSize TextColor:UIColor.blackColor Alignment:(NSTextAlignmentCenter)];
}
+ (instancetype)kj_createLabelWithText:(NSString*)text FontSize:(CGFloat)fontSize TextColor:(UIColor*)color{
    return [self kj_createLabelWithText:text FontSize:fontSize TextColor:color Alignment:(NSTextAlignmentCenter)];
}
+ (instancetype)kj_createLabelWithText:(NSString*)text FontSize:(CGFloat)fontSize TextColor:(UIColor*)color Alignment:(NSTextAlignment)alignment{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.textAlignment = alignment;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    return label;
}
@end
