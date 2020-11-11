//
//  _KJGCD.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler

#ifndef _KJGCD_h
#define _KJGCD_h

// 同步会阻塞主线程

#pragma mark ********** 11.线程 GCD   *********
/* 使用方式 kGCD_MAIN_ASYNC(^{ NSLog(@"77"); }); */
//GCD - 异步主线程
#define kGCD_MAIN_ASYNC(main_queue_block) dispatch_async(dispatch_get_main_queue(), main_queue_block)
//GCD - 异步子线程
#define kGCD_QUEUE_ASYNC(global_queue_block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), global_queue_block)
//GCD - 一次性执行
#define kGCD_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 异步并行队列
#define kGCD_GROUP_ASYNC(group_async_block,group_notify_block) \
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);\
dispatch_group_t group = dispatch_group_create();\
dispatch_group_async(group, queue, group_async_block);\
dispatch_group_notify(group, queue, ^{\
dispatch_async(dispatch_get_main_queue(), group_notify_block);\
})\

#pragma mark - GCD 线程处理
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

#endif /* _KJGCD_h */
