//
//  UIView+KJGestureBlock.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIView+KJGestureBlock.h"
#import <objc/runtime.h>

@implementation UIView (KJGestureBlock)
/// 单击手势
- (UIGestureRecognizer*)kj_AddTapGestureRecognizerBlock:(KJGestureRecognizerBlock)block{
    return [self kj_AddGestureRecognizer:KJGestureTypeTap block:block];
}

- (UIGestureRecognizer*)kj_AddGestureRecognizer:(KJGestureType)type block:(KJGestureRecognizerBlock)block{
    self.userInteractionEnabled = YES;
    if (block) {
        NSString *string = KJGestureTypeStringMap[type];
        __block UIGestureRecognizer *gesture = [[NSClassFromString(string) alloc] initWithTarget:self action:@selector(kGestureAction:)];
        [gesture setDelaysTouchesBegan:YES];
        [self addGestureRecognizer:gesture];
        if (type == KJGestureTypeTap) {
            self.gesrureblock = block;
            [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer *recognizer, NSUInteger idx, BOOL *stop) {
                if ([recognizer isKindOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer*)recognizer).numberOfTapsRequired == 2) {
                    [gesture requireGestureRecognizerToFail:recognizer];
                    *stop = YES;
                }
            }];
        }else if (type == KJGestureTypeDouble) {
            self.doublegesrureblock = block;
            [(UITapGestureRecognizer*)gesture setNumberOfTapsRequired:2];
            [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer *recognizer, NSUInteger idx, BOOL *stop) {
                if ([recognizer isKindOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer*)recognizer).numberOfTapsRequired == 1) {
                    [recognizer requireGestureRecognizerToFail:gesture];
                    *stop = YES;
                }
            }];
        }else if (type == KJGestureTypeLongPress) {
            self.longgesrureblock = block;
        }else if (type == KJGestureTypeSwipe) {
            self.swipegesrureblock = block;
        }else if (type == KJGestureTypePan) {
            self.pangesrureblock = block;
        }else if (type == KJGestureTypeRotate) {
            self.rotategesrureblock = block;
        }else if (type == KJGestureTypePinch) {
            self.pinchgesrureblock = block;
        }
        return gesture;
    }
    return nil;
}

- (void)kGestureAction:(UIGestureRecognizer*)gesture{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        if (((UITapGestureRecognizer*)gesture).numberOfTapsRequired == 1) {
            if (self.gesrureblock) self.gesrureblock(gesture.view, gesture);
        }else {
            if (self.doublegesrureblock) self.doublegesrureblock(gesture.view, gesture);
        }
    }else if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
        if (self.longgesrureblock) self.longgesrureblock(gesture.view, gesture);
    }else if ([gesture isKindOfClass:[UISwipeGestureRecognizer class]]) {
        if (self.swipegesrureblock) self.swipegesrureblock(gesture.view, gesture);
    }else if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
        if (self.pangesrureblock) self.pangesrureblock(gesture.view, gesture);
    }else if ([gesture isKindOfClass:[UIRotationGestureRecognizer class]]) {
        if (self.rotategesrureblock) self.rotategesrureblock(gesture.view, gesture);
    }else if ([gesture isKindOfClass:[UIPinchGestureRecognizer class]]) {
        if (self.pinchgesrureblock) self.pinchgesrureblock(gesture.view, gesture);
    }
}

#pragma mark - associated
- (KJGestureRecognizerBlock)gesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(gesrureblock));
}
- (void)setGesrureblock:(KJGestureRecognizerBlock)gesrureblock{
    objc_setAssociatedObject(self, @selector(gesrureblock), gesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (KJGestureRecognizerBlock)doublegesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(doublegesrureblock));
}
- (void)setDoublegesrureblock:(KJGestureRecognizerBlock)doublegesrureblock{
    objc_setAssociatedObject(self, @selector(doublegesrureblock), doublegesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (KJGestureRecognizerBlock)longgesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(longgesrureblock));
}
- (void)setLonggesrureblock:(KJGestureRecognizerBlock)longgesrureblock{
    objc_setAssociatedObject(self, @selector(longgesrureblock), longgesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (KJGestureRecognizerBlock)swipegesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(gesrureblock));
}
- (void)setSwipegesrureblock:(KJGestureRecognizerBlock)swipegesrureblock{
    objc_setAssociatedObject(self, @selector(swipegesrureblock), swipegesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (KJGestureRecognizerBlock)pangesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(pangesrureblock));
}
- (void)setPangesrureblock:(KJGestureRecognizerBlock)pangesrureblock{
    objc_setAssociatedObject(self, @selector(pangesrureblock), pangesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (KJGestureRecognizerBlock)rotategesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(rotategesrureblock));
}
- (void)setRotategesrureblock:(KJGestureRecognizerBlock)rotategesrureblock{
    objc_setAssociatedObject(self, @selector(rotategesrureblock), rotategesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (KJGestureRecognizerBlock)pinchgesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(pinchgesrureblock));
}
- (void)setPinchgesrureblock:(KJGestureRecognizerBlock)pinchgesrureblock{
    objc_setAssociatedObject(self, @selector(pinchgesrureblock), pinchgesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
