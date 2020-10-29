//
//  UIButton+KJIndicator.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  指示器

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJIndicator)
/// 按钮是否正在提交中
@property(nonatomic, readonly, getter=isSubmitting) NSNumber *submitting;
/// 开始提交，指示器跟随文字
- (void)kj_beginSubmitting:(NSString*)title;
/// 结束提交
- (void)kj_endSubmitting;
/// 显示指示器
- (void)kj_showIndicator;
/// 隐藏指示器
- (void)kj_hideIndicator;

@end

NS_ASSUME_NONNULL_END
