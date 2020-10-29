//
//  UILabel+KJAttributedString.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UILabel+KJAttributedString.h"

@implementation UILabel (KJAttributedString)

- (void)kj_AttributedStringTextLineSpace:(CGFloat)space{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)kj_AttributedStringTextFont:(UIFont *)font Range:(NSRange)range{
    [self kj_AttributedStringTextAttributes:@{NSFontAttributeName:font} Range:range];
}

- (void)kj_AttributedStringTextColor:(UIColor *)color Range:(NSRange)range{
    [self kj_AttributedStringTextAttributes:@{NSForegroundColorAttributeName:color} Range:range];
}

- (void)kj_AttributedStringTextFont:(UIFont *)font TextColor:(UIColor *)color Range:(NSRange)range{
    [self kj_AttributedStringTextAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} Range:range];
}

- (void)kj_AttributedStringTextAttributes:(NSDictionary *)attributes Range:(NSRange)range{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *name in attributes){
        [mutableAttributedString addAttribute:name value:[attributes objectForKey:name] range:range];
    }
    self.attributedText = mutableAttributedString;
}

- (void)kj_AttributedStringTextFont:(UIFont *)font  Loc:(NSInteger)loc Len:(NSInteger)len{
    NSRange range = NSMakeRange(loc, len);
    [self kj_AttributedStringTextAttributes:@{NSFontAttributeName:font} Range:range];
}

- (void)kj_AttributedStringTextColor:(UIColor *)color  Loc:(NSInteger)loc Len:(NSInteger)len{
    NSRange range = NSMakeRange(loc, len);
    [self kj_AttributedStringTextAttributes:@{NSForegroundColorAttributeName:color} Range:range];
}

- (void)kj_AttributedStringTextFont:(UIFont *)font TextColor:(UIColor *)color Loc:(NSInteger)loc Len:(NSInteger)len{
    NSRange range = NSMakeRange(loc, len);
    [self kj_AttributedStringTextAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} Range:range];
}

- (void)kj_AttributedStringTextAttributes:(NSDictionary *)attributes Loc:(NSInteger)loc Len:(NSInteger)len{
    NSRange range = NSMakeRange(loc, len);
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *name in attributes){
        [mutableAttributedString addAttribute:name value:[attributes objectForKey:name] range:range];
    }
    self.attributedText = mutableAttributedString;
}

@end

