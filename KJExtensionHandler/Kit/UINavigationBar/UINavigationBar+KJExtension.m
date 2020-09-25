//
//  UINavigationBar+KJExtension.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "UINavigationBar+KJExtension.h"
#import <objc/runtime.h>

@interface UINavigationBar ()
@property(nonatomic,copy) UIView *kj_view;
@end
//static UIView * kk_view = nil;
@implementation UINavigationBar (KJExtension)

#pragma mark - associated
- (UIColor *)kj_BackgroundColor{
    return objc_getAssociatedObject(self, @selector(kj_BackgroundColor));
}
- (void)setKj_BackgroundColor:(UIColor *)kj_BackgroundColor{
    objc_setAssociatedObject(self, @selector(kj_BackgroundColor), kj_BackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!self.kj_view) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.kj_view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.kj_view.userInteractionEnabled = NO;
        self.kj_view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.kj_view atIndex:0];
    }
    self.kj_view.backgroundColor = kj_BackgroundColor;
}

- (CGFloat)kj_Alpha{
    return [objc_getAssociatedObject(self, @selector(kj_Alpha)) floatValue];
}
- (void)setKj_Alpha:(CGFloat)kj_Alpha{
    objc_setAssociatedObject(self, @selector(kj_Alpha), @(kj_Alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop){
        view.alpha = kj_Alpha;
    }];
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop){
        view.alpha = kj_Alpha;
    }];
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = kj_Alpha;
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop){
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]){
            obj.alpha = kj_Alpha;
            *stop = YES;
        }
    }];
}

- (CGFloat)kj_TranslationY{
    return [objc_getAssociatedObject(self, @selector(kj_TranslationY)) floatValue];
}
- (void)setKj_TranslationY:(CGFloat)kj_TranslationY{
    objc_setAssociatedObject(self, @selector(kj_TranslationY), @(kj_TranslationY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeTranslation(0, kj_TranslationY);
}

/// 重置
- (void)kj_reset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.kj_view removeFromSuperview];
    self.kj_view = nil;
}

#pragma mark - lazzing
- (UIView*)kj_view{
    return objc_getAssociatedObject(self, @selector(kj_view));
}
- (void)setKj_view:(UIView *)kj_view{
    objc_setAssociatedObject(self, @selector(kj_view), kj_view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//- (UIView*)kj_view{
//    kk_view = objc_getAssociatedObject(self, @selector(kj_view));
//    if (!kk_view){
//        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        kk_view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
//        kk_view.userInteractionEnabled = NO;
//        kk_view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        objc_setAssociatedObject(self, @selector(kj_view), kk_view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        [self insertSubview:kk_view atIndex:0];
//    }
//    return kk_view;
//}

@end


