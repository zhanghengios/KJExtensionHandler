//
//  UIButton+KJBlock.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJBlock.h"
#import <objc/runtime.h>

@implementation UIButton (KJBlock)
static char ActionTag;
/// button 添加点击事件 默认点击方式UIControlEventTouchUpInside
- (void)kj_addAction:(KJButtonBlock)block{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}
/// button 添加事件 controlEvents 点击的方式
- (void)kj_addAction:(KJButtonBlock)block forControlEvents:(UIControlEvents)controlEvents{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}
/// button 事件的响应方法
- (void)action:(UIButton*)sender{
    KJButtonBlock blockAction = (KJButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction) blockAction(self);
}

#pragma mark - 时间相关方法交换
/// 是否开启时间间隔的方法交换
+ (void)kj_openTimeExchangeMethod{
    SEL originalSelector = @selector(sendAction:to:forEvent:);
    SEL swizzledSelector = @selector(kj_sendAction:to:forEvent:);
    Class clazz = [self class];
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);
    BOOL boo = class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (boo) {
        class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (NSTimeInterval)kj_AcceptEventTime{
    return [objc_getAssociatedObject(self, @selector(kj_AcceptEventTime)) doubleValue];
}
- (void)setKj_AcceptEventTime:(NSTimeInterval)kj_AcceptEventTime{
    objc_setAssociatedObject(self, @selector(kj_AcceptEventTime), @(kj_AcceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)kj_AcceptDealTime{
    return [objc_getAssociatedObject(self, @selector(kj_AcceptDealTime)) doubleValue];
}
- (void)setKj_AcceptDealTime:(NSTimeInterval)kj_AcceptDealTime{
    objc_setAssociatedObject(self, @selector(kj_AcceptDealTime), @(kj_AcceptDealTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 上一次时间
- (NSTimeInterval)kLastTime{
    return [objc_getAssociatedObject(self, @selector(kLastTime)) doubleValue];
}
- (void)setKLastTime:(NSTimeInterval)kLastTime{
    objc_setAssociatedObject(self, @selector(kLastTime), @(kLastTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 交换方法后实现
- (void)kj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.kj_AcceptEventTime <= 0 && self.kj_AcceptDealTime <= 0) {
        [self kj_sendAction:action to:target forEvent:event];
        return;
    }
    // 时间间隔判断
    NSTimeInterval time = self.kj_AcceptEventTime > 0 ? self.kj_AcceptEventTime : self.kj_AcceptDealTime;
    BOOL boo = (NSDate.date.timeIntervalSince1970 - self.kLastTime >= time);
    // 保存上次点击时间
    if (self.kj_AcceptEventTime > 0) self.kLastTime = NSDate.date.timeIntervalSince1970;
    if (boo) {
        if (self.kj_AcceptDealTime > 0) self.kLastTime = NSDate.date.timeIntervalSince1970;
        [self kj_sendAction:action to:target forEvent:event];
    }
}

@end
