//
//  UITextView+KJBackout.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/10.
//  https://github.com/yangKJ/KJExtensionHandler
//  撤销处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (KJBackout)
/// 是否开启撤销功能
@property(nonatomic,assign)bool kOpenBackout;
/// 撤销输入，相当于 command + z
- (void)kj_textViewBackout;

@end

NS_ASSUME_NONNULL_END
