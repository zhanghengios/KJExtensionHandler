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
/// 粒子素材，默认自带粒子图片尺寸 60x60 - 此属性应再 kj_openButtonEmitter 之前设置
@property(nonatomic,strong) UIImage *kj_buttonEmitterImage;
/// 开启点赞粒子效果
@property(nonatomic,assign) BOOL kj_openButtonEmitter;

@end

NS_ASSUME_NONNULL_END
