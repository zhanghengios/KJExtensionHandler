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
@property(nonatomic,copy) UIView *backView;
@end
@implementation UINavigationBar (KJExtension)
- (UIView*)backView{
    return objc_getAssociatedObject(self, @selector(backView));
}
- (void)setBackView:(UIView*)backView{
    objc_setAssociatedObject(self, @selector(backView), backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor*)kj_BackgroundColor{
    return objc_getAssociatedObject(self, @selector(kj_BackgroundColor));
}
- (void)setKj_BackgroundColor:(UIColor *)kj_BackgroundColor{
    objc_setAssociatedObject(self, @selector(kj_BackgroundColor), kj_BackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.backView == nil) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)+20)];
        self.backView.userInteractionEnabled = NO;
        self.backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.backView atIndex:0];
    }
    self.backView.backgroundColor = kj_BackgroundColor;
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
    [self.backView removeFromSuperview];
    self.backView = nil;
}

@end


