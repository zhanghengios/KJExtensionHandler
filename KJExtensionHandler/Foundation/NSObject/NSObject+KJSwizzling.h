//
//  NSObject+KJSwizzling.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/18.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJSwizzling)
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
