//
//  UIView+KJRectCorner.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  圆角扩展 - 边框

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (KJRectCorner)
/// 圆角半径，默认5px
@property(nonatomic,assign)CGFloat kj_radius;
/// 圆角方位
@property(nonatomic,assign)UIRectCorner kj_rectCorner;

/// 边框颜色，默认黑色
@property(nonatomic,strong)UIColor *kj_borderColor;
/// 边框宽度，默认1px
@property(nonatomic,assign)CGFloat kj_borderWidth;
/// Top边框
@property(nonatomic,assign)bool kj_borderTop;
/// Bottom边框
@property(nonatomic,assign)bool kj_borderBottom;
/// Left边框
@property(nonatomic,assign)bool kj_borderLeft;
/// Right边框
@property(nonatomic,assign)bool kj_borderRight;

@end
NS_ASSUME_NONNULL_END
