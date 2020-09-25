//
//  UIView+KJXib.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "UIView+KJXib.h"

@implementation UIView (KJXib)

@dynamic borderColor,borderWidth,cornerRadius;
@dynamic shadowColor,shadowRadius,shadowOffset,shadowOpacity;

/// 判断一个控件是否真正显示在主窗口
- (BOOL)kj_isShowingOnKeyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
/// xib创建的view
+ (instancetype)kj_viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame {
    UIView *view = [self kj_viewFromXib];
    view.frame = frame;
    return view;
}
/// 寻找子视图
- (UIView*)kj_FindSubviewRecursively:(BOOL(^)(UIView *subview, BOOL *stop))recurse{
    for (UIView *view in self.subviews) {
        BOOL stop = NO;
        if(recurse(view, &stop)) {
            return [view kj_FindSubviewRecursively:recurse];
        }else if(stop) {
            return view;
        }
    }
    return nil;
}
/// 当前的控制器
- (UIViewController*)kj_currentViewController{
    id next = self;
    for (; next; next = [next superview]) {
        UIResponder *responder = [next nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}
/// xib中显示的属性
- (void)setBorderColor:(UIColor *)borderColor {
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
- (void)setShadowColor:(UIColor *)shadowColor{
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
