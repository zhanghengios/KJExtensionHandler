//
//  UIButton+KJEmitter.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/15.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJEmitter.h"
#import <objc/runtime.h>

@implementation UIButton (KJEmitter)
/// 设置粒子效果
- (void)kj_buttonSetEmitterImage:(UIImage*_Nullable)image OpenEmitter:(bool)open{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(setSelected:)), class_getInstanceMethod(self.class, @selector(kj_setSelected:)));
    });
    self.emitterImage = image?:[UIImage imageNamed:@"KJKit.bundle/button_sparkle"];
    self.emitterOpen = open;
    [self setupLayer];
}
/// 方法交换
- (void)kj_setSelected:(BOOL)selected{
    [self kj_setSelected:selected];
    if (self.emitterOpen) [self buttonAnimation];
}

- (UIImage*)emitterImage{
    return objc_getAssociatedObject(self, @selector(emitterImage));
}
- (void)setEmitterImage:(UIImage*)emitterImage{
    objc_setAssociatedObject(self, @selector(emitterImage), emitterImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)emitterOpen{
    return [objc_getAssociatedObject(self, @selector(emitterOpen)) intValue];
}
- (void)setEmitterOpen:(BOOL)emitterOpen{
    objc_setAssociatedObject(self, @selector(emitterOpen), @(emitterOpen), OBJC_ASSOCIATION_ASSIGN);
}
- (CAEmitterLayer*)explosionLayer{
    return objc_getAssociatedObject(self, @selector(explosionLayer));
}
- (void)setExplosionLayer:(CAEmitterLayer *)explosionLayer{
    objc_setAssociatedObject(self, @selector(explosionLayer), explosionLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 粒子效果相关
- (void)setupLayer{
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.name = @"name";
    emitterCell.alphaRange = 0.10;
    emitterCell.lifetime = 0.7;
    emitterCell.lifetimeRange = 0.3;
    emitterCell.velocity = 40.00;
    emitterCell.velocityRange = 10.00;
    emitterCell.scale = 0.04;
    emitterCell.scaleRange = 0.02;
    emitterCell.contents = (id)self.emitterImage.CGImage;
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.name = @"emitterLayer";
    emitterLayer.emitterShape = kCAEmitterLayerCircle;
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterSize = CGSizeMake(10, 0);
    emitterLayer.emitterCells = @[emitterCell];
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    emitterLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    emitterLayer.zPosition = -1;
    [self.layer addSublayer:emitterLayer];
    self.explosionLayer = emitterLayer;
}
/// 开始动画
- (void)buttonAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (self.selected) {
        animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
        animation.duration = 0.4;
        /// 开始喷射
        self.explosionLayer.beginTime = CACurrentMediaTime();
        [self.explosionLayer setValue:@2000 forKeyPath:@"emitterCells.name.birthRate"];
        [self performSelector:@selector(stop) withObject:nil afterDelay:0.2];
    }else{
        animation.values = @[@0.8, @1.0];
        animation.duration = 0.2;
    }
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}
/// 停止喷射
- (void)stop {
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.name.birthRate"];
}

@end
