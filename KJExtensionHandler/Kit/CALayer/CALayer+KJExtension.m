//
//  CALayer+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/12.
//  https://github.com/yangKJ/KJExtensionHandler

#import "CALayer+KJExtension.h"
#import <objc/runtime.h>
@implementation CALayer (KJExtension)

- (NSInteger)kTag{
    return [objc_getAssociatedObject(self, @selector(kTag)) integerValue];
}
- (void)setKTag:(NSInteger)kTag{
    objc_setAssociatedObject(self, @selector(kTag), @(kTag), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
