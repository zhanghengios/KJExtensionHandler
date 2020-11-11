//
//  UITextView+KJLimitCounter.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  限制处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol KJTextViewLimitExchangeMethodProtocol <NSObject>
@required
+ (void)kj_openLimitExchangeMethod;
@end
@interface UITextView (KJLimitCounter)<KJTextViewLimitExchangeMethodProtocol>
/// 限制字数
@property(nonatomic,assign)NSInteger kj_limitCount;
/// 限制区域右边距，默认10
@property(nonatomic,assign)CGFloat kj_limitMargin;
/// 限制区域高度，默认20
@property(nonatomic,assign)CGFloat kj_limitHeight;
/// 统计限制字数Label
@property(nonatomic,strong,readonly)UILabel *kj_limitLabel;

@end

NS_ASSUME_NONNULL_END
