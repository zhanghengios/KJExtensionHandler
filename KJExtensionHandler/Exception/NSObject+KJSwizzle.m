//
//  NSObject+KJSwizzle.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/18.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJSwizzle.h"

@implementation NSObject (KJSwizzle)
+ (BOOL)kj_swizzleMethod:(SEL)origSel Method:(SEL)altSel{
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod  = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) return NO;
    class_addMethod(self, origSel, class_getMethodImplementation(self, origSel), method_getTypeEncoding(origMethod));
    class_addMethod(self, altSel, class_getMethodImplementation(self, altSel), method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
    return YES;
}

@end
