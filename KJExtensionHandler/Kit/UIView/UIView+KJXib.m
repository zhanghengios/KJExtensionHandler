//
//  UIView+KJXib.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIView+KJXib.h"

@implementation UIView (KJXib)
/// xib创建的view
+ (instancetype)kj_viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame {
    UIView *view = [self kj_viewFromXib];
    view.frame = frame;
    return view;
}
/// 判断一个控件是否真正显示在主窗口
- (BOOL)kj_isShowingOnKeyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
- (BOOL)showKeyWindow{
    return [self kj_isShowingOnKeyWindow];
}
/// 当前的控制器
- (UIViewController*)kj_currentViewController{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }while (responder);
    return nil;
}
- (UIViewController*)viewController{
    return [self kj_currentViewController];
}
- (UIViewController*)topViewController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)vc;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result = nav.childViewControllers.lastObject;
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)vc;
        result = nav.childViewControllers.lastObject;
    }else{
        result = vc;
    }
    return result;
}

/// Xib中显示的属性
@dynamic borderColor,borderWidth,cornerRadius;
@dynamic shadowColor,shadowRadius,shadowOffset,shadowOpacity;
- (void)setBorderColor:(UIColor*)borderColor {
    [self.layer setBorderColor:borderColor.CGColor];
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth <= 0) return;
    [self.layer setBorderWidth:borderWidth];
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
    self.layer.masksToBounds = cornerRadius > 0;
}
- (void)setShadowColor:(UIColor*)shadowColor{
    [self.layer setShadowColor:shadowColor.CGColor];
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    [self.layer setShadowRadius:shadowRadius];
}
- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    [self.layer setShadowOpacity:shadowOpacity];
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    [self.layer setShadowOffset:shadowOffset];
}

@end
