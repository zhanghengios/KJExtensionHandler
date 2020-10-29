//
//  UILabel+KJAttributedString.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  富文本

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KJAttributedString)
/* Range之间文字行间距 */
- (void)kj_AttributedStringTextLineSpace:(CGFloat)space;
/* Range之间文字大小 */
- (void)kj_AttributedStringTextFont:(UIFont*)font Range:(NSRange)range;
/* Range之间文字颜色 */
- (void)kj_AttributedStringTextColor:(UIColor*)color Range:(NSRange)range;
/* Range之间文字大小 和 颜色 */
- (void)kj_AttributedStringTextFont:(UIFont*)font TextColor:(UIColor*)color Range:(NSRange)range;
/* Range之间文字相关属性 */
- (void)kj_AttributedStringTextAttributes:(NSDictionary*)attributes Range:(NSRange)range;

/* 富文本文字大小 loc:起始位置 len:长度 */
- (void)kj_AttributedStringTextFont:(UIFont*)font Loc:(NSInteger)loc Len:(NSInteger)len;
/* 富文本文字颜色 loc:起始位置 len:长度 */
- (void)kj_AttributedStringTextColor:(UIColor*)color Loc:(NSInteger)loc Len:(NSInteger)len;
/* 富文本文字大小和颜色 loc:起始位置 len:长度 和 颜色 */
- (void)kj_AttributedStringTextFont:(UIFont*)font TextColor:(UIColor*)color Loc:(NSInteger)loc Len:(NSInteger)len;
/* 富文本文字相关属性 loc:起始位置 len:长度 */
- (void)kj_AttributedStringTextAttributes:(NSDictionary*)attributes Loc:(NSInteger)loc Len:(NSInteger)len;

@end

NS_ASSUME_NONNULL_END
