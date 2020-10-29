//
//  UIScrollView+KJGestureConflict.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/17.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIScrollView+KJGestureConflict.h"
#import <objc/runtime.h>
@implementation UIScrollView (KJGestureConflict)
///// 处理UIScrollView上的手势和侧滑返回手势的冲突
//- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer{
//    /// 判断系统pop手势
//    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
//        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
//            return YES;/// 判断滚动位置
//        }
//    }
//    return NO;
//}
//- (bool)kDelConflict{
//    return [objc_getAssociatedObject(self,@selector(kDelConflict)) boolValue];
//}
//- (void)setKDelConflict:(bool)kDelConflict{
//    objc_setAssociatedObject(self,@selector(kDelConflict),[NSNumber numberWithBool:kDelConflict],OBJC_ASSOCIATION_ASSIGN);
//}
///// 处理UISlider的滑动与UIScrollView的滑动事件冲突
//- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (self.kDelConflict == false) return view;
//    self.scrollEnabled = ![view isKindOfClass:[UISlider class]];
//    return view;
//}
///// 解决UISlider滑动和全屏侧滑pop冲突
///*
///// 在支持全屏侧滑返回的UINavigationController的子类中，遵守协议
//#pragma mark -- UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch{
//    if ([touch.view isKindOfClass:[UISlider class]]) {
//        return NO;
//    }
//    return YES;
//}
//*/

@end
