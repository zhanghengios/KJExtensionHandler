//
//  UIView+KJRectCorner.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  进阶版圆角和边框扩展

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger, KJBorderOrientationType) {
    KJBorderOrientationTypeUnknown= 1 << 0,/// 未知边
    KJBorderOrientationTypeTop    = 1 << 1,/// 上边
    KJBorderOrientationTypeBottom = 1 << 2,/// 下边
    KJBorderOrientationTypeLeft   = 1 << 3,/// 左边
    KJBorderOrientationTypeRight  = 1 << 4,/// 右边
};
@interface UIView (KJRectCorner)
/// 圆角半径，默认5px
@property(nonatomic,assign)CGFloat kj_radius;
/// 圆角方位
@property(nonatomic,assign)UIRectCorner kj_rectCorner;

/// 边框颜色，默认黑色
@property(nonatomic,strong)UIColor *kj_borderColor;
/// 边框宽度，默认1px
@property(nonatomic,assign)CGFloat kj_borderWidth;
/// 边框方位，在颜色和宽度之后执行
@property(nonatomic,assign)KJBorderOrientationType kj_borderOrientation;

@end
NS_ASSUME_NONNULL_END
