//
//  NSNull+KJSafe.m
//  iSchool
//
//  Created by 杨科军 on 2019/1/3.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "NSNull+KJSafe.h"
#import <objc/runtime.h>

//若未定义NULLSAFE_ENABLED宏，则定义为1；若定义过NULLSAFE_ENABLED为0，下列代码则不执行，学习此种宏控制的代码执行方式
#ifndef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif

#pragma GCC diagnostic ignored "-Wgnu-conditional-omitted-operand"

@implementation NSNull (KJSafe)

#if NULLSAFE_ENABLED
//NSNull对象找不到方法就会走这个方法。
//消息转发机制使用从这个方法中获取的信息来创建NSInvocation对象。因此我们必须重写这个方法，为给定的selector提供一个合适的方法签名。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector{
    //synchronized线程锁
    @synchronized([self class]) {
        //取selector方法的签名
        NSMethodSignature *signature = [super methodSignatureForSelector:selector];
        if (!signature) {
            //not supported by NSNull, search other classes
            //注意这里全局静态变量的使用技巧，下次调用时，以下变量不会被置nil了（静态变量不能重复初始化）
            static NSMutableSet *classList = nil;
            static NSMutableDictionary *signatureCache = nil;
            
            if (signatureCache == nil) {
                classList = [[NSMutableSet alloc] init];
                signatureCache = [[NSMutableDictionary alloc] init];
                
                //------------获取所有根父类的类集合----------------------------------
                //获取到当前注册的所有类的总个数
                int numClasses = objc_getClassList(NULL, 0);
                //根据 numClasses 个数调整分配类集合 classes 的空间
                Class *classes = (Class *)malloc(sizeof(Class) * (unsigned long)numClasses);
                //向已分配好内存空间的类集合 classes 中存放元素，并返回个数
                numClasses = objc_getClassList(classes, numClasses);
                
                //excluded存储含有父类的类
                NSMutableSet *excluded = [NSMutableSet set];
                for (int i = 0; i < numClasses; i++){
                    Class someClass = classes[i];
                    Class superclass = class_getSuperclass(someClass);
                    //如果父类是NSObject，说明已无父类，把class加到classList
                    //如果父类不是NSObject，把superClass加到excluded集合（自动剔除重复），继续遍历其父类，直到父类是NSObject，退出循环
                    while (superclass){
                        if (superclass == [NSObject class]) {
                            [classList addObject:someClass];
                            break;
                        }
                        [excluded addObject:NSStringFromClass(superclass)];
                        superclass = class_getSuperclass(superclass);
                    }
                }
                
                //移除所有含有父类的类，只保留根父类，原因下面会解释= =
                for (Class someClass in excluded) {
                    [classList removeObject:someClass];
                }
                //-------------------------------------------------------------------
                
                //释放classes集合
                free(classes);
            }
            
            //查找缓存集合
            NSString *selectorString = NSStringFromSelector(selector);
            signature = signatureCache[selectorString];
            //在根父类的类集合classList中，查询某类是否实现selector方法
            if (!signature){
                for (Class someClass in classList){
                    //此方法会查询someClass及其子类是否有实现selector方法
                    if ([someClass instancesRespondToSelector:selector]){
                        signature = [someClass instanceMethodSignatureForSelector:selector];
                        break;
                    }
                }
                //若获得了selector方法签名，赋值signatureCache[selectorString] = signature(学习此种三目运算使用技巧)；
                //若未获得，把静态字典signatureCache[selectorString] = [NSNull null];这样处理是为了若再次查找此selector方法的时候，直接在上面“signature = signatureCache[selectorString];”中signature获得为NSNull，这样就会走下面的else判断
                signatureCache[selectorString] = signature ?: [NSNull null];
            }
            else if ([signature isKindOfClass:[NSNull class]]){
                //若未实现，就把selector方法签名置为nil，不会走下面forwardInvocation，直接crash，因为所有类都找不到此方法
                signature = nil;
            }
        }
        
        //signature若不为nil，接下来会走forwardInvocation方法
        return signature;
    }
}

//运行时系统会在这一步给消息接收者最后一次机会将消息转发给其它对象。对象会创建一个表示消息的NSInvocation对象，把与尚未处理的消息有关的全部细节都封装在anInvocation中，包括selector，目标(target)和参数。
- (void)forwardInvocation:(NSInvocation *)invocation{
    //关键点在这里！将消息转发给nil
    invocation.target = nil;
    [invocation invoke];
}

#endif


@end

