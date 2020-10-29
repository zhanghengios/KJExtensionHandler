//
//  KJExceptionTool.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/10.
//  https://github.com/yangKJ/KJExtensionHandler
//  异常捕获处理

#import <Foundation/Foundation.h>
#import "KJExceptionProtocol.h"
#import "NSArray+KJException.h"
#import "NSDictionary+KJException.h"
#import "NSMutableArray+KJException.h"
#import "NSMutableDictionary+KJException.h"
#import "NSMutableString+KJException.h"
NS_ASSUME_NONNULL_BEGIN
typedef BOOL (^kExceptionBlock)(NSDictionary *dict);
@interface KJExceptionTool : NSObject
/// 开启全部方法交换，只需要开启单个则使用 [NSArray kj_openExchangeMethod];
+ (void)kj_openAllExchangeMethod;
/// 异常回调处理，只需要在最开始的地方调用
+ (void)kj_crashBlock:(kExceptionBlock)block;
/// 异常获取
+ (void)kj_crashDealWithException:(NSException*)exception CrashTitle:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
