//
//  UIButton+KJEmitter.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/15.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  按钮粒子效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJEmitter)
/// 设置粒子效果
- (void)kj_buttonSetEmitterImage:(UIImage*_Nullable)image OpenEmitter:(bool)open;

@end

NS_ASSUME_NONNULL_END
