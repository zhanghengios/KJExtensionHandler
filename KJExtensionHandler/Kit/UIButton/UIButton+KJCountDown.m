//
//  UIButton+KJCountDown.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJCountDown.h"
#import <objc/runtime.h>
@implementation UIButton (KJCountDown)
- (NSTimer*)timer{
    return objc_getAssociatedObject(self, @selector(timer));
}
- (void)setTimer:(NSTimer*)timer{
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString*)xxtitle{
    return objc_getAssociatedObject(self, @selector(xxtitle));
}
- (void)setXxtitle:(NSString*)xxtitle{
    objc_setAssociatedObject(self, @selector(xxtitle), xxtitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setKButtonCountDownStop:(void(^)(void))kButtonCountDownStop {
    objc_setAssociatedObject(self, @selector(kButtonCountDownStop), kButtonCountDownStop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void(^)(void))kButtonCountDownStop{
    return objc_getAssociatedObject(self, @selector(kButtonCountDownStop));
}
- (NSInteger)timeOut{
    return [objc_getAssociatedObject(self, @selector(timeOut)) integerValue];
}
- (void)setTimeOut:(NSInteger)timeOut{
    objc_setAssociatedObject(self, @selector(timeOut), @(timeOut), OBJC_ASSOCIATION_ASSIGN);
}
- (void)kj_startTime:(NSInteger)timeout CountDownFormat:(NSString*)format{
    [self kj_cancelTimer];
    self.timeOut = timeout;
    self.xxtitle = self.titleLabel.text;
    NSDictionary *info = @{@"countDownFormat":format ?: @"%zd秒"};
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod:) userInfo:info repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)timerMethod:(NSTimer*)timer{
    NSDictionary *info = timer.userInfo;
    NSString *countDownFormat = info[@"countDownFormat"];
    if(self.timeOut <= 0){ 
        [self kj_cancelTimer];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTitle:[NSString stringWithFormat:countDownFormat,self.timeOut % 60] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
        });
        self.timeOut--;
    }
}
/// 取消倒计时
- (void)kj_cancelTimer{
    if (self.timer == nil) return;
    [self.timer invalidate];
    self.timer = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:self.xxtitle forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        if (self.kButtonCountDownStop) { self.kButtonCountDownStop(); }
    });
}
@end
