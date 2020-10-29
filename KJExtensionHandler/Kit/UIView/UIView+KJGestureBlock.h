//
//  UIView+KJGestureBlock.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  手势Block

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^KJGestureRecognizerBlock)(UIView *view, UIGestureRecognizer *gesture);
typedef NS_ENUM(NSUInteger, KJGestureType) {
    KJGestureTypeTap,       // 点击
    KJGestureTypeDouble,    // 双击
    KJGestureTypeLongPress, // 长按
    KJGestureTypeSwipe,     // 轻扫
    KJGestureTypePan,       // 移动
    KJGestureTypeRotate,    // 旋转
    KJGestureTypePinch,     // 缩放
};
/// 枚举映射字符串
static NSString * const _Nonnull KJGestureTypeStringMap[] = {
    [KJGestureTypeTap]       = @"UITapGestureRecognizer",
    [KJGestureTypeDouble]    = @"UITapGestureRecognizer",
    [KJGestureTypeLongPress] = @"UILongPressGestureRecognizer",
    [KJGestureTypeSwipe]     = @"UISwipeGestureRecognizer",
    [KJGestureTypePan]       = @"UIPanGestureRecognizer",
    [KJGestureTypeRotate]    = @"UIRotationGestureRecognizer",
    [KJGestureTypePinch]     = @"UIPinchGestureRecognizer",
};

@interface UIView (KJGestureBlock)
/*
 [self.view kj_AddGestureRecognizer:KJGestureTypeTap block:^(UIView *view, UIGestureRecognizer *gesture) {
     // example
     [view removeGestureRecognizer:gesture];
 }];
 */
- (UIGestureRecognizer*)kj_AddGestureRecognizer:(KJGestureType)type block:(KJGestureRecognizerBlock)block;
/// 单击手势
- (UIGestureRecognizer*)kj_AddTapGestureRecognizerBlock:(KJGestureRecognizerBlock)block;

@end

NS_ASSUME_NONNULL_END
