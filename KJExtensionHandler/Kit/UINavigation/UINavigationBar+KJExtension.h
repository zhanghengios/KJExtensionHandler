//
//  UINavigationBar+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (KJExtension)
/// 设置navigationBar背景颜色
@property(nonatomic,strong) UIColor *kj_BackgroundColor;
/// 设置基础的透明度
@property(nonatomic,assign) CGFloat kj_Alpha;
@property(nonatomic,assign) CGFloat kj_TranslationY;
/// 重置
- (void)kj_reset;

@end

NS_ASSUME_NONNULL_END
