//
//  UICollectionView+KJTouch.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/18.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "UICollectionView+KJTouch.h"
#import <objc/runtime.h>
@implementation NSObject (Swizzling)
+ (BOOL)kj_swizzleMethod:(SEL)origSel Method:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod  = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) return NO;
    class_addMethod(self, origSel, class_getMethodImplementation(self, origSel), method_getTypeEncoding(origMethod));
    class_addMethod(self, altSel, class_getMethodImplementation(self, altSel), method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
    return YES;
}
@end

@implementation UICollectionView (Touch)
- (bool)kOpenExchange{
    return [objc_getAssociatedObject(self,@selector(kOpenExchange)) boolValue];
}
- (void)setKOpenExchange:(bool)kOpenExchange{
    objc_setAssociatedObject(self,@selector(kOpenExchange),[NSNumber numberWithBool:kOpenExchange],OBJC_ASSOCIATION_ASSIGN);
}
- (KJMoveBlock)moveblock{
    return (KJMoveBlock)objc_getAssociatedObject(self, @selector(moveblock));
}
- (void)setMoveblock:(KJMoveBlock)moveblock{
    objc_setAssociatedObject(self, @selector(moveblock), moveblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self kj_swizzleMethod:@selector(touchesBegan:withEvent:) Method:@selector(kj_touchesBegan:withEvent:)];
        [self kj_swizzleMethod:@selector(touchesMoved:withEvent:) Method:@selector(kj_touchesMoved:withEvent:)];
        [self kj_swizzleMethod:@selector(touchesEnded:withEvent:) Method:@selector(kj_touchesEnded:withEvent:)];
        [self kj_swizzleMethod:@selector(touchesCancelled:withEvent:) Method:@selector(kj_touchesCancelled:withEvent:)];
    });
}
- (void)kj_touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.kOpenExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeBegin,point);
    }
    [self kj_touchesBegan:touches withEvent:event];
}
- (void)kj_touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.kOpenExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeMove,point);
    }
    [self kj_touchesMoved:touches withEvent:event];
}
- (void)kj_touchesEnded:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.kOpenExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeEnd,point);
    }
    [self kj_touchesEnded:touches withEvent:event];
}
- (void)kj_touchesCancelled:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.kOpenExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeCancelled,point);
    }
    [self kj_touchesEnded:touches withEvent:event];
}
@end
