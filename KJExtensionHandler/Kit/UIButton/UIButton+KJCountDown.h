//
//  UIButton+KJCountDown.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  倒计时

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJCountDown)
/// 倒计时结束的回调
@property(nonatomic,copy,readwrite)void(^kButtonCountDownStop)(void);
/// 设置倒计时的间隔和倒计时文案，默认为 @"%zd秒"
- (void)kj_startTime:(NSInteger)timeout CountDownFormat:(NSString*)format;
/// 取消倒计时
- (void)kj_cancelTimer;

@end

NS_ASSUME_NONNULL_END
