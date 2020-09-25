//
//  UIColor+KJExtension2.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// RGBA
typedef struct KJColorRGBA {
    float red;
    float green;
    float blue;
    float alpha;
}KJColorRGBA;
/// 色相饱和度和亮度
typedef struct KJColorHSL {
    float hue;/// 色相 -π ~ π
    float saturation; /// 饱和度 0 ~ 1
    float light; /// 亮度 0 ~ 1
}KJColorHSL;
@interface UIColor (KJExtension2)
@property(nonatomic,assign,readonly)CGFloat red;
@property(nonatomic,assign,readonly)CGFloat green;
@property(nonatomic,assign,readonly)CGFloat blue;
@property(nonatomic,assign,readonly)CGFloat alpha;
@property(nonatomic,assign,readonly)CGFloat hue;/// 色相 -π ~ π
@property(nonatomic,assign,readonly)CGFloat saturation;/// 饱和度 0 ~ 1
@property(nonatomic,assign,readonly)CGFloat light;/// 亮度 0 ~ 1
/// 获取颜色对应的RGBA
- (KJColorRGBA)kj_colorGetRGBA;
/// 获取颜色对应的色相饱和度和透明度
- (KJColorHSL)kj_colorGetHSL;
/// 获取颜色的均值
+ (UIColor*)kj_averageColors:(NSArray<UIColor*>*)colors;
@end

NS_ASSUME_NONNULL_END
