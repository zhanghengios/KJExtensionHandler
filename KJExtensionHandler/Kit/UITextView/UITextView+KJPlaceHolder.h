//
//  UITextView+KJPlaceHolder.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol KJTextViewPlaceHolderExchangeMethodProtocol <NSObject>
@required
+ (void)kj_openPlaceHolderExchangeMethod;
@end
@interface UITextView (KJPlaceHolder)<KJTextViewPlaceHolderExchangeMethodProtocol>
/// 占位符文字
@property(nonatomic,strong)NSString *kj_placeHolder;
/// 占位符Label
@property(nonatomic,strong,readonly)UILabel *kj_placeHolderLabel;
@end
NS_ASSUME_NONNULL_END
