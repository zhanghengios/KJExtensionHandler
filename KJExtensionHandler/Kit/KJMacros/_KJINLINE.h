//
//  _KJINLINE.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/10.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

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

#pragma mark - 简单函数
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
/// 强制让App直接退出（非闪退，非崩溃）
NS_INLINE void kExitApplication(NSTimeInterval duration,void(^block)(void)) {
    [UIView animateWithDuration:duration animations:block completion:^(BOOL finished) {
        exit(0);
    }];
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

#pragma mark - UI处理
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

#pragma mark - Json相关
/// 字典转Json字符串
NS_INLINE NSString * kDictionaryToJson(NSDictionary *dict){
    NSString *jsonString = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
/// 数组转Json字符串
NS_INLINE NSString * kArrayToJson(NSArray *array){
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonTemp;
}
/// Json字符串转字典
NS_INLINE NSDictionary *kJsonToDictionary(NSString *string){
    if (string == nil) return nil;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return nil;
    return dic;
}

#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
#endif

#endif /* _KJINLINE_h */
