//
//  UIViewController+KJFullScreen.m
//  Winpower
//
//  Created by 杨科军 on 2019/10/10.
//  Copyright © 2019 cq. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIViewController+KJFullScreen.h"
#import <objc/runtime.h>

@implementation UIViewController (KJFullScreen)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector = @selector(kj_presentViewController:animated:completion:);
        Class class = [self class];
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)kj_presentViewController:(UIViewController*)vc animated:(BOOL)animated completion:(void(^)(void))completion{
    if (@available(iOS 13.0, *)) {
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;/// 充满全屏
    }
    [self kj_presentViewController:vc animated:animated completion:completion];
}

@end
