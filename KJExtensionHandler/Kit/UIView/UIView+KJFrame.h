//
//  UIView+KJFrame.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  一套轻量级布局

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (KJFrame)
/// x坐标
@property (nonatomic,assign)CGFloat x;
/// y坐标
@property (nonatomic,assign)CGFloat y;
/// 宽度
@property (nonatomic,assign)CGFloat width;
/// 高度
@property (nonatomic,assign)CGFloat height;
/// 大小
@property (nonatomic,assign)CGSize size;
/// 位置
@property (nonatomic,assign)CGPoint origin;
/// 中心点x
@property (nonatomic,assign)CGFloat centerX;
/// 中心点y
@property (nonatomic,assign)CGFloat centerY;
/// 左边距离
@property (nonatomic,assign)CGFloat left;
/// 右边距离
@property (nonatomic,assign)CGFloat right;
/// 顶部距离
@property (nonatomic,assign)CGFloat top;
/// 底部距离
@property (nonatomic,assign)CGFloat bottom;
/// x + width
@property (nonatomic,assign,readonly)CGFloat maxX;
/// y + height
@property (nonatomic,assign,readonly)CGFloat maxY;

/// 使用Masonry布局之后得到尺寸
@property (nonatomic,assign)CGFloat masonry_x;
@property (nonatomic,assign)CGFloat masonry_y;
@property (nonatomic,assign)CGFloat masonry_width;
@property (nonatomic,assign)CGFloat masonry_height;

/// 寻找子视图
- (UIView*)kj_FindSubviewRecursively:(BOOL(^)(UIView *subview, BOOL * stop))recurse;
/// 移除所有子视图
- (void)kj_removeAllSubviews;
/// 移动时刻显示阴影效果
- (void)kj_movingShadow;

@end

NS_ASSUME_NONNULL_END
