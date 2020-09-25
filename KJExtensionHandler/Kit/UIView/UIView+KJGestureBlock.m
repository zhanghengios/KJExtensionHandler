//
//  UIView+KJGestureBlock.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  

#import "UIView+KJGestureBlock.h"
#import <objc/runtime.h>

@implementation UIView (KJGestureBlock)
static const char *KJGestureBlockKey;
/// 单击手势
- (UIGestureRecognizer*)kj_AddTapGestureRecognizerBlock:(KJGestureRecognizerBlock)block{
    return [self kj_AddGestureRecognizer:KJGestureTypeTap block:block];
}

- (UIGestureRecognizer*)kj_AddGestureRecognizer:(KJGestureType)type block:(KJGestureRecognizerBlock)block{
    self.userInteractionEnabled = YES; /// 开启可交互
    if (block) {
        NSString *string = KJGestureTypeStringMap[type];
        UIGestureRecognizer *gesture = [[NSClassFromString(string) alloc] initWithTarget:self action:@selector(kGestureAction:)];
        [gesture setDelaysTouchesBegan:YES];// 解决点击当前view时候响应其他控件事件
        /// 单指双击
        if (type == KJGestureTypeDouble) {
            for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
                if ([recognizer isKindOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer*)recognizer).numberOfTapsRequired == 1) {
                    [recognizer requireGestureRecognizerToFail:gesture];//如果双击成立，则取消单击手势（双击的时候不回走单击事件）
                }
            }
            ((UITapGestureRecognizer*)gesture).numberOfTouchesRequired = 1;//手指数
            ((UITapGestureRecognizer*)gesture).numberOfTapsRequired = 2;
        }
        [self addGestureRecognizer:gesture];
        NSMutableDictionary *dict = objc_getAssociatedObject(self, KJGestureBlockKey);
        if (dict == nil) {
            dict = [NSMutableDictionary dictionary];
            objc_setAssociatedObject(self, KJGestureBlockKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [dict setObject:block forKey:string];
        return gesture;
    }
    return nil;
}

- (void)kGestureAction:(UIGestureRecognizer*)gesture{
    NSMutableDictionary *dict = objc_getAssociatedObject(gesture.view, KJGestureBlockKey);
    KJGestureRecognizerBlock block = dict[NSStringFromClass([gesture class])];
    !block?:block(gesture.view, gesture);
}

@end
