//
//  CALayer+KJReflection.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/4/22.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  倒影

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (KJReflection)

/// 透明度
@property (nonatomic,assign) CGFloat kj_reflectionOpacity;
/// 模糊
@property (nonatomic,assign) CGFloat kj_reflectionFuzzy;
/// 距离大小
@property (nonatomic,assign) CGFloat kj_reflectionSize;
/// 特别注意是否隐藏Navigation
@property (nonatomic,assign) BOOL kj_reflectionHideNavigation;
/// 添加倒影
- (void)kj_addReflection;


/* 备注：图片的填充方式对倒影效果有影响，如果图片显示底边未填充满，则会出现空隙 */
/// 手动调整图片间隙距离 - 非必传参数
@property (nonatomic,assign) CGFloat kj_reflectionImageSpace;

// **************** 内部参数 不需要设置 ****************
/// 倒影层 - 图片旋转180度
@property (nonatomic,strong) CALayer *kj_reflectionLayer;
/// 镜像层上的遮蔽层
@property (nonatomic,strong) CAGradientLayer *kj_gradientLayer;

@end

NS_ASSUME_NONNULL_END
