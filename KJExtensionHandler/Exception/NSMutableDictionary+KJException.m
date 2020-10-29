//
//  NSMutableDictionary+KJException.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/10.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSMutableDictionary+KJException.h"

@implementation NSMutableDictionary (KJException)
+ (void)kj_openExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSDictionaryM") kj_swizzleMethod:@selector(setObject:forKey:) Method:@selector(kj_setObject:forKey:)];
        [objc_getClass("__NSDictionaryM") kj_swizzleMethod:@selector(setValue:forKey:) Method:@selector(kj_setValue:forKey:)];
        [objc_getClass("__NSDictionaryM") kj_swizzleMethod:@selector(removeObjectForKey:) Method:@selector(kj_removeObjectForKey:)];
    });
}
- (void)kj_setObject:(id)object forKey:(id)key{
    @try {
        [self kj_setObject:object forKey:key];
    }@catch (NSException *exception) {
        NSString *string = @"Exception handling ignore this operation to avoid crash: ";
        if (key == nil || object == nil) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"字典赋值存在空 key:%@, val:%@",key,object]];
        }
        [KJExceptionTool kj_crashDealWithException:exception CrashTitle:string];
    }@finally {
        
    }
}
- (void)kj_setValue:(id)object forKey:(id)key{
    @try {
        [self kj_setValue:object forKey:key];
    }@catch (NSException *exception) {
        NSString *string = @"Exception handling ignore this operation to avoid crash: ";
        if (key == nil || object == nil) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"字典赋值存在空 key:%@, val:%@",key,object]];
        }
        [KJExceptionTool kj_crashDealWithException:exception CrashTitle:string];
    }@finally {
        
    }
}
- (void)kj_removeObjectForKey:(id)key{
    @try {
        [self kj_removeObjectForKey:key];
    }@catch (NSException *exception) {
        NSString *string = @"Exception handling ignore this operation to avoid crash: ";
        if (key == nil) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"字典移除键为空 key:%@",key]];
        }
        [KJExceptionTool kj_crashDealWithException:exception CrashTitle:string];
    }@finally {
        
    }
}

@end

