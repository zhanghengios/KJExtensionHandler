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
- (KJGestureRecognizerBlock)gesrureblock{
    return (KJGestureRecognizerBlock)objc_getAssociatedObject(self, @selector(gesrureblock));
}
- (void)setGesrureblock:(KJGestureRecognizerBlock)gesrureblock{
    objc_setAssociatedObject(self, @selector(gesrureblock), gesrureblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/// 单击手势
- (UIGestureRecognizer*)kj_AddTapGestureRecognizerBlock:(KJGestureRecognizerBlock)block{
    return [self kj_AddGestureRecognizer:KJGestureTypeTap block:block];
}

- (UIGestureRecognizer*)kj_AddGestureRecognizer:(KJGestureType)type block:(KJGestureRecognizerBlock)block{
    self.userInteractionEnabled = YES;
    self.gesrureblock = block;
    if (block) {
        NSString *string = KJGestureTypeStringMap[type];
        UIGestureRecognizer *gesture = [[NSClassFromString(string) alloc] initWithTarget:self action:@selector(kGestureAction:)];
        [gesture setDelaysTouchesBegan:YES];
        [self addGestureRecognizer:gesture];
        if (type == KJGestureTypeDouble) {
            ((UITapGestureRecognizer*)gesture).numberOfTouchesRequired = 1;
            ((UITapGestureRecognizer*)gesture).numberOfTapsRequired = 2;
            for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
                if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
                    if (((UITapGestureRecognizer*)recognizer).numberOfTapsRequired == 1) {
                        [recognizer requireGestureRecognizerToFail:gesture];
                    }
                }
            }
        }
        return gesture;
    }
    return nil;
}

- (void)kGestureAction:(UIGestureRecognizer*)gesture{
    if (self.gesrureblock) self.gesrureblock(gesture.view, gesture);
}

@end
