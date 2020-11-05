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
/// 判断是否有子视图在滚动
- (BOOL)kj_anySubViewScrolling{
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)self;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    for (UIView *subview in self.subviews) {
        if ([subview kj_anySubViewScrolling]) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)anySubViewScrolling{
    return [self kj_anySubViewScrolling];
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
@dynamic viewImage;
@dynamic borderColor,borderWidth,cornerRadius;
@dynamic shadowColor,shadowRadius,shadowOffset,shadowOpacity;
- (void)setViewImage:(UIImage*)viewImage{
    if (viewImage) {
        CALayer *topLayer = [[CALayer alloc]init];
        [topLayer setBounds:self.bounds];
        [topLayer setPosition:CGPointMake(self.bounds.size.width*.5, self.bounds.size.height*.5)];
        [topLayer setContents:(id)viewImage.CGImage];
        [self.layer addSublayer:topLayer];
    }
}
- (void)setBorderColor:(UIColor*)borderColor {
    [self.layer setBorderColor:borderColor.CGColor];
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth <= 0) return;
    [self.layer setBorderWidth:borderWidth];
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius <= 0) return;
    [self.layer setCornerRadius:cornerRadius];
    self.layer.masksToBounds = YES;
    /// 设置光栅化，可以使离屏渲染的结果缓存到内存中存为位图，使用的时候直接使用缓存，节省了一直离屏渲染损耗的性能
    self.layer.shouldRasterize = YES;
}
- (void)setShadowColor:(UIColor*)shadowColor{
    [self.layer setShadowColor:shadowColor.CGColor];
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    if (shadowRadius <= 0) return;
    [self.layer setShadowRadius:shadowRadius];
}
- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    [self.layer setShadowOpacity:shadowOpacity];
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    [self.layer setShadowOffset:shadowOffset];
}

@end
