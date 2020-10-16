//
//  NSObject+KJSignal.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/15.
//  信号处理工具
//  使用方案：
/*
 在View当中发送消息
 UIViewController *vc = [NSClassFromString(dic[@"VCName"]) new];
 [self kj_sendSignalWithKey:kHomeViewKey Message:vc Parameter:dic];
 
 在ViewController当中处理事件
 [NSObject kj_receivedSignalWithSender:view SignalBlock:^id _Nullable(NSString * _Nonnull key, id  _Nonnull message, id  _Nonnull parameter) {
     if ([key isEqualToString:kHomeViewKey]) {
         ((UIViewController*)message).title = ((NSDictionary*)parameter)[@"describeName"];
         [weakself.navigationController pushViewController:message animated:true];
     }
     return nil;
 }];
*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef id _Nullable (^kSignalBlock)(NSString *key, id message, id parameter);
@interface NSObject (KJSignal)
/// 发送消息处理
- (id)kj_sendSignalWithKey:(NSString*)key Message:(id)message Parameter:(id _Nullable)parameter;
/// 接收消息处理
- (void)kj_receivedSignalWithSender:(NSObject*)sender SignalBlock:(kSignalBlock)block;

@end

NS_ASSUME_NONNULL_END
