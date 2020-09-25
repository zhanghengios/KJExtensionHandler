//
//  _KJINLINE.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/10.
//  Copyright © 2019 杨科军. All rights reserved.
//

#ifndef _KJINLINE_h
#define _KJINLINE_h

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "UIColor+KJExtension.h"

/// 这里只适合放简单的函数
NS_ASSUME_NONNULL_BEGIN

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

NS_INLINE void kUncaughtExceptionHandler(NSException *exception) {
    NSLog(@"**************** 崩溃日志收集器 ****************");
    NSLog(@"%@",exception);
    NSLog(@"%@",exception.callStackReturnAddresses);
    NSLog(@"%@",exception.callStackSymbols);
    NSLog(@"*********************************************");
}
/// 简单崩溃日志收集，AppDelegate里注册函数
NS_INLINE void kUncaughtException(void){
    NSSetUncaughtExceptionHandler(&kUncaughtExceptionHandler);
}
/// 随机颜色
NS_INLINE UIColor * kRandomColor(){
    return [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0) green:((float)arc4random_uniform(256)/255.0) blue:((float)arc4random_uniform(256)/255.0) alpha:1.0];
}
/// 交换方法的实现
NS_INLINE void kMethodSwizzling(Class clazz, SEL original, SEL swizzled) {
    Method method   = class_getInstanceMethod(clazz, original);
    Method swmethod = class_getInstanceMethod(clazz, swizzled);
    if (class_addMethod(clazz, original, method_getImplementation(swmethod), method_getTypeEncoding(swmethod))) {
        class_replaceMethod(clazz, swizzled, method_getImplementation(method), method_getTypeEncoding(method));
    }else {
        method_exchangeImplementations(method, swmethod);
    }
}
/// 透明图片穿透
NS_INLINE bool kTransparentImage(UIImageView *imageView, CGPoint point){
    UIColor *color = [UIColor kj_colorAtImageView:imageView Point:point];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    if (NULL != components) {
        float aplphaF = components[3];
        if ((aplphaF >= 0.01)) return false;
    }
    return true;
}
/// 字符串是否为空
NS_INLINE bool kEmptyString(NSString *string){
    return ([string isKindOfClass:[NSNull class]] || string == nil || [string length] < 1 ? YES : NO);
}
/// 数组是否为空
NS_INLINE bool kEmptyArray(NSArray *array){
    return (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0);
}
/// 字典是否为空
NS_INLINE bool kEmptyDictionary(NSDictionary *dic){
    return (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0);
}
/// 是否是空对象
NS_INLINE bool kEmptyObject(NSObject *object){
    return (object == nil || [object isKindOfClass:[NSNull class]] || ([object respondsToSelector:@selector(length)] && [(NSData*)object length] == 0) || ([object respondsToSelector:@selector(count)] && [(NSArray*)object count] == 0));
}

#pragma mark -------------- UI处理 -------------
/// 自定提醒窗口
NS_INLINE UIAlertView * kAlertView(NSString *title, NSString *message, id delegate, NSString *cancelTitle, NSString *otherTitle){
    __block UIAlertView *alerView;
    dispatch_async(dispatch_get_main_queue(), ^{
        alerView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
        [alerView show];
    });
    return alerView;
}
/// 自定提醒窗口，自动消失
NS_INLINE void kAlertViewAutoDismiss(NSString *message, CGFloat delay){
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alerView show];
        [alerView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:@[@0,@1] afterDelay:delay];
    });
}
/// 系统加载动效
NS_INLINE void kNetworkActivityIndicatorVisible(BOOL visible) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
}
/// 通过xib名称加载cell
NS_INLINE id kLoadNibWithName(NSString *name, id owner){
   return [[NSBundle mainBundle] loadNibNamed:name owner:owner options:nil].firstObject;
}
/// 加载xib
NS_INLINE id kLoadNib(NSString *name){
    return [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
}
/// 校正ScrollView在iOS11上的偏移问题
NS_INLINE void kAdjustsScrollViewInsetNever(UIViewController *viewController, __kindof UIScrollView *tableView) {
#if __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        viewController.automaticallyAdjustsScrollViewInsets = false;
    }
#else
    viewController.automaticallyAdjustsScrollViewInsets = false;
#endif
}
/// 根据当前view 找所在tableview 里的 indexpath
NS_INLINE NSIndexPath * kIndexpathSubviewTableview(UIView *subview, UITableView *tableview){
    CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];
    return [tableview indexPathForRowAtPoint:subviewFrame.origin];
}
/// 根据当前view 找所在collectionview 里的 indexpath
NS_INLINE NSIndexPath * kIndexpathSubviewCollectionview(UIView *subview, UICollectionView *collectionview){
    CGRect subviewFrame = [subview convertRect:subview.bounds toView:collectionview];
    return [collectionview indexPathForItemAtPoint:subviewFrame.origin];
}
/// 根据当前view 找所在tableview 里的 tableviewcell
NS_INLINE UITableViewCell * kCellSubviewTableview(UIView *subview, UITableView *tableview){
    CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];
    NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];
    return [tableview cellForRowAtIndexPath:indexPath];
}
/// 强制让App直接退出（非闪退，非崩溃）
NS_INLINE void kExitApplication(NSTimeInterval duration,void(^block)(void)) {
    [UIView animateWithDuration:duration animations:block completion:^(BOOL finished) {
        exit(0);
    }];
}
#pragma mark -------------- GCD 线程处理 -------------
NS_INLINE dispatch_queue_t kGCD_queue(void) {
    //    dispatch_queue_t queue = dispatch_queue_create("com.yangkejun.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    return queue;
}
/// 主线程
NS_INLINE void kGCD_main(dispatch_block_t block) {
    if ([[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), block);
    }else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
/// 子线程
NS_INLINE void kGCD_async(dispatch_block_t block) {
    dispatch_async(kGCD_queue(), block);
}
/// 异步并行队列，携带可变参数（需要nil结尾）
NS_INLINE void kGCD_group_notify(dispatch_block_t notify,dispatch_block_t block,...) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, block);
    va_list args;dispatch_block_t arg;
    va_start(args, block);
    while ((arg = va_arg(args, dispatch_block_t))) {
        dispatch_group_async(group, queue, arg);
    }
    va_end(args);
    dispatch_group_notify(group, queue, notify);
}
/// 栅栏
NS_INLINE dispatch_queue_t kGCD_barrier(dispatch_block_t block,dispatch_block_t barrier) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_async(queue, block);
    dispatch_barrier_async(queue, ^{ dispatch_async(dispatch_get_main_queue(), barrier); });
    return queue;
}
/// 一次性
NS_INLINE void kGCD_once(dispatch_block_t block) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, block);
}
/// 延时执行
NS_INLINE void kGCD_after(int64_t delayInSeconds, dispatch_block_t block) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(time, queue, block);
}
/// 主线程当中延时执行
NS_INLINE void kGCD_main_after(int64_t delayInSeconds, dispatch_block_t block) {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), block);
}
/// 快速迭代
NS_INLINE void kGCD_apply(int iterations, void(^block)(size_t idx)) {
    dispatch_queue_t queue = kGCD_queue();
    dispatch_apply(iterations, queue, block);
}
/// 计时器
static dispatch_source_t timer = nil;
NS_INLINE dispatch_source_t kGCD_timer(int64_t delayInSeconds, dispatch_block_t block) {
    if (timer) dispatch_source_cancel(timer);
    dispatch_queue_t queue = kGCD_queue();
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), delayInSeconds * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, block);
    dispatch_resume(timer);
    return timer;
}

#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
#endif

#endif /* _KJINLINE_h */
