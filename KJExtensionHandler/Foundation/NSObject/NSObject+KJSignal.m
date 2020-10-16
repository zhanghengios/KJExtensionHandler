//
//  NSObject+KJSignal.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/15.
//

#import "NSObject+KJSignal.h"
#import <objc/runtime.h>
@implementation NSObject (KJSignal)
- (kSignalBlock)signalblock{
    return objc_getAssociatedObject(self, @selector(signalblock));
}
- (void)setSignalblock:(kSignalBlock)signalblock{
    objc_setAssociatedObject(self, @selector(signalblock), signalblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/// 发送消息处理
- (id)kj_sendSignalWithKey:(NSString*)key Message:(id)message Parameter:(id _Nullable)parameter{
#ifdef DEBUG
    NSLog(@"\nSenderKey:%@\n控制器:%@\n发送者:%@\n携带参数:%@",key,message,self,parameter);
#endif
    if (self.signalblock) {
        return self.signalblock(key, message, parameter);
    }else{
        return nil;
    }
}
/// 接收消息处理
- (void)kj_receivedSignalWithSender:(NSObject*)sender SignalBlock:(kSignalBlock)block{
    if (!sender) return;
    sender.signalblock = block;
}

@end
