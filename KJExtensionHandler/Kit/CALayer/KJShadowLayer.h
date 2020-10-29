//
//  KJShadowLayer.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/4/28.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  内发光、外发光、内阴影、外阴影

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
/// 阴影类型
typedef NS_ENUM(NSInteger, KJShadowType) {
    KJShadowTypeInner, /// 内阴影
    KJShadowTypeOuter, /// 外阴影
    KJShadowTypeInnerShine, /// 内发光
    KJShadowTypeOuterShine, /// 外发光
};
@interface KJShadowLayer : CALayer<NSCopying>
/* 路径 */
@property (nonatomic, strong) UIBezierPath *kj_shadowPath;
/* 颜色 */
@property (nonatomic, strong) UIColor *kj_shadowColor;
/* 透明度 */
@property (nonatomic, assign) CGFloat kj_shadowOpacity;
/* 半径（大小）*/
@property (nonatomic, assign) CGFloat kj_shadowRadius;
/* 偏移 */
@property (nonatomic, assign) CGSize kj_shadowOffset;

// ***************************** 非Layer自带参数 **********************************
/* 距离（扩展）*/
@property (nonatomic, assign) CGFloat kj_shadowDiffuse;
/* 角度 */
@property (nonatomic, assign) CGFloat kj_shadowAngle;

/// 初始化
- (instancetype)kj_initWithFrame:(CGRect)frame ShadowType:(KJShadowType)type;

/// 提供一套阴影角度算法 angele:范围（0-360）distance:距离
- (CGSize)kj_innerShadowAngle:(CGFloat)angle Distance:(CGFloat)distance;

@end

NS_ASSUME_NONNULL_END
