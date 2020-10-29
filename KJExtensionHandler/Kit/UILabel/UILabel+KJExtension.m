//
//  UILabel+KJExtension.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UILabel+KJExtension.h"

@implementation UILabel (KJExtension)
- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width{
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [UILabel kj_calculateLabelSizeWithTitle:self.text font:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    size.height += 3;
    return size.height;
}

- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width OneLineHeight:(CGFloat)height{
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [UILabel kj_calculateLabelSizeWithTitle:self.text font:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height * height / self.font.lineHeight;
}

/// 获取文字尺寸
+ (CGSize)kj_calculateLabelSizeWithTitle:(NSString*)title font:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode{
    if (title.length == 0) return CGSizeZero;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = lineBreakMode;
    CGRect frame = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraph} context:nil];
    return frame.size;
}

@end
