//
//  UIButton+KJButtonContentLayout.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/7.
//  Copyright © 2017年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  图文混排

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Button 图文样式
typedef NS_ENUM(NSInteger, KJButtonContentLayoutStyle) {
    KJButtonContentLayoutStyleNormal = 0,       // 内容居中-图左文右
    KJButtonContentLayoutStyleCenterImageRight, // 内容居中-图右文左
    KJButtonContentLayoutStyleCenterImageTop,   // 内容居中-图上文下
    KJButtonContentLayoutStyleCenterImageBottom,// 内容居中-图下文上
    KJButtonContentLayoutStyleLeftImageLeft,    // 内容居左-图左文右
    KJButtonContentLayoutStyleLeftImageRight,   // 内容居左-图右文左
    KJButtonContentLayoutStyleRightImageLeft,   // 内容居右-图左文右
    KJButtonContentLayoutStyleRightImageRight,  // 内容居右-图右文左
};
IB_DESIGNABLE /// Xib 动态刷新
@interface UIButton (KJButtonContentLayout)
/// 图文样式
@property(nonatomic,assign) IBInspectable KJButtonContentLayoutStyle kj_ButtonContentLayoutType;
/// 图文间距
@property(nonatomic,assign) IBInspectable CGFloat kj_Padding;
/// 图文边界的间距，默认为5px
@property(nonatomic,assign) IBInspectable CGFloat kj_PaddingInset;

@end

NS_ASSUME_NONNULL_END


