//
//  NSArray+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSArray+KJExtension.h"

@implementation NSArray (KJExtension)
- (bool)isEmpty{
    return (self == nil || [self isKindOfClass:[NSNull class]] || self.count == 0);
}

@end
