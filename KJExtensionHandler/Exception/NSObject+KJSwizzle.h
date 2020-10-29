//
//  NSObject+KJSwizzle.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/18.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "KJExceptionTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJSwizzle)
/// 方法交换
+ (BOOL)kj_swizzleMethod:(SEL)origSel Method:(SEL)altSel;
@end

NS_ASSUME_NONNULL_END
