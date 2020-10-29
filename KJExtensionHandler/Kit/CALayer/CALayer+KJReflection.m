//
//  CALayer+KJReflection.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/4/22.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "CALayer+KJReflection.h"
#import <objc/runtime.h>

@implementation CALayer (KJReflection)
- (CGFloat)kj_reflectionOpacity {
    return [objc_getAssociatedObject(self, @selector(kj_reflectionOpacity)) doubleValue];
}
- (void)setKj_reflectionOpacity:(CGFloat)reflectionOpacity {
    objc_setAssociatedObject(self, @selector(kj_reflectionOpacity), @(reflectionOpacity), OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.kj_reflectionLayer) {
        self.kj_reflectionLayer.opacity = reflectionOpacity;
    }
}
- (CGFloat)kj_reflectionFuzzy {
    return [objc_getAssociatedObject(self, @selector(kj_reflectionFuzzy)) doubleValue];
}
- (void)setKj_reflectionFuzzy:(CGFloat)reflectionFuzzy {
    objc_setAssociatedObject(self, @selector(kj_reflectionFuzzy), @(reflectionFuzzy), OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.kj_gradientLayer) {
        self.kj_gradientLayer.locations = @[@(reflectionFuzzy),@1];
    }
}
- (CGFloat)kj_reflectionSize {
    return [objc_getAssociatedObject(self, @selector(kj_reflectionSize)) doubleValue];
}
- (void)setKj_reflectionSize:(CGFloat)reflectionSize {
    objc_setAssociatedObject(self, @selector(kj_reflectionSize), @(reflectionSize), OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.kj_reflectionLayer) {
        CGFloat m  = h*reflectionSize;
        CGFloat cy = b+(h+m)*.5+nav;
        self.kj_gradientLayer.bounds = self.kj_reflectionLayer.bounds = CGRectMake(0, 0, w, m);
        self.kj_reflectionLayer.position = CGPointMake(a, cy);
        self.kj_gradientLayer.position = CGPointMake(w/2, m/2);
    }
}
- (BOOL)kj_reflectionHideNavigation {
    return [objc_getAssociatedObject(self, @selector(kj_reflectionHideNavigation)) boolValue];
}
- (void)setKj_reflectionHideNavigation:(BOOL)reflectionHideNavigation {
    objc_setAssociatedObject(self, @selector(kj_reflectionHideNavigation), [NSNumber numberWithBool:reflectionHideNavigation], OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)kj_reflectionImageSpace {
    return [objc_getAssociatedObject(self, @selector(kj_reflectionImageSpace)) doubleValue];
}
- (void)setKj_reflectionImageSpace:(CGFloat)kj_reflectionImageSpace {
    objc_setAssociatedObject(self, @selector(kj_reflectionImageSpace), @(kj_reflectionImageSpace), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
// 倒影层(图片旋转180度）
- (CALayer*)kj_reflectionLayer{
    return objc_getAssociatedObject(self, @selector(kj_reflectionLayer));
}
- (void)setKj_reflectionLayer:(CALayer*)reflectionLayer {
    objc_setAssociatedObject(self, @selector(kj_reflectionLayer), reflectionLayer, OBJC_ASSOCIATION_ASSIGN);
}
// 镜像层上的遮蔽层
- (CAGradientLayer*)kj_gradientLayer{
    return objc_getAssociatedObject(self, @selector(kj_gradientLayer));
}
- (void)setKj_gradientLayer:(CAGradientLayer*)gradientLayer {
    objc_setAssociatedObject(self, @selector(kj_gradientLayer), gradientLayer, OBJC_ASSOCIATION_ASSIGN);
}
/// 添加倒影
static CGFloat w,h,a,b,nav;
- (void)kj_addReflection{
    w = self.bounds.size.width;
    h = self.bounds.size.height;
    a = self.position.x;
    b = self.position.y;
    nav = self.kj_reflectionHideNavigation ? 20 : 64;
    nav -= self.kj_reflectionImageSpace;
    CGFloat m = h*self.kj_reflectionSize;
    CGFloat cy = b+(h+m)*.5+nav;
    //倒影(图片旋转180度)
    CALayer *xLayer = [[CALayer alloc] init];
    xLayer.bounds = CGRectMake(0, 0, w, m);
    xLayer.position = CGPointMake(a, cy);
    xLayer.contents = [self contents];
    [xLayer setValue:[NSNumber numberWithFloat:M_PI] forKeyPath:@"transform.rotation.x"];
    xLayer.opacity = self.kj_reflectionOpacity;
    self.kj_reflectionLayer = xLayer;
    
    //创建镜像层上的遮蔽层
    CAGradientLayer *gLayer = [[CAGradientLayer alloc] init];
    gLayer.bounds = xLayer.bounds;
    gLayer.position = CGPointMake(w/2, m/2);
    gLayer.colors = @[(id)UIColor.clearColor.CGColor,(id)UIColor.blackColor.CGColor];
    gLayer.locations = @[@(self.kj_reflectionFuzzy),@1];
    gLayer.startPoint = CGPointMake(0.5,0.0);
    gLayer.endPoint = CGPointMake(0.5,1.0);
    //设置倒影的遮蔽层
    [xLayer setMask:gLayer];
    self.kj_gradientLayer = gLayer;
    
    [self.superlayer addSublayer:xLayer];
}

@end
