//
//  UIResponder+KJAdapt.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/14.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIResponder+KJAdapt.h"
#import <objc/runtime.h>
@implementation UIResponder (KJAdapt)
+ (KJAdaptModelType)adaptType{
    return (KJAdaptModelType)[objc_getAssociatedObject(self, @selector(adaptType)) intValue];
}
+ (void)setAdaptType:(KJAdaptModelType)adaptType{
    objc_setAssociatedObject(self, @selector(adaptType), @(adaptType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)kj_adaptModelType:(KJAdaptModelType)type{
    self.adaptType = type;
}
CGFloat KJAdaptScaleLevel(CGFloat level){
    if (level == 0) return 0.0;
    CGFloat width;
    switch (UIResponder.adaptType) {
        case KJAdaptTypeIPhone4:width = 320;break;
        case KJAdaptTypeIPhone5:width = 320;break;
        case KJAdaptTypeIPhone6:width = 375;break;
        case KJAdaptTypeIPhone6P:width = 414;break;
        case KJAdaptTypeIPhoneX:width = 375;break;
        case KJAdaptTypeIPhoneXR:width = 414;break;
        case KJAdaptTypeIPhoneXSMax:width = 414;break;
        default:break;
    }
    return level*([[UIScreen mainScreen]bounds].size.width/width);
}
CGFloat KJAdaptScaleVertical(CGFloat vertical){
    return KJAdaptScaleLevel(vertical);
}
CGPoint KJAdaptPointMake(CGFloat x, CGFloat y){
    return CGPointMake(KJAdaptScaleLevel(x), KJAdaptScaleVertical(y));
}
CGSize KJAdaptSizeMake(CGFloat width, CGFloat height){
    return CGSizeMake(KJAdaptScaleLevel(width), KJAdaptScaleVertical(height));
}
CGRect KJAdaptRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    return CGRectMake(KJAdaptScaleLevel(x), KJAdaptScaleVertical(y), KJAdaptScaleLevel(width), KJAdaptScaleVertical(height));
}
UIEdgeInsets KJAdaptEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right){
    return UIEdgeInsetsMake(KJAdaptScaleVertical(top), KJAdaptScaleLevel(left), KJAdaptScaleVertical(bottom), KJAdaptScaleLevel(right));
}

@end
