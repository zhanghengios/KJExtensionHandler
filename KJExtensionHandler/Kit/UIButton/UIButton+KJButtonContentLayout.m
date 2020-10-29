//
//  UIButton+KJButtonContentLayout.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/7.
//  Copyright © 2017年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJButtonContentLayout.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kButtonContentLayoutTypeKey = @"kj_buttonContentLayoutTypeKey";
static NSString * const kPaddingKey = @"kj_paddingKey";
static NSString * const kPaddingInsetKey = @"kj_paddingInsetKey";

@implementation UIButton (KJContentLayout)

- (void)setupButtonLayout{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth  = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    if (self.kj_PaddingInset == 0) self.kj_PaddingInset = 5;
    switch (self.kj_ButtonContentLayoutType) {
        case KJButtonContentLayoutStyleNormal:{
            titleEdge = UIEdgeInsetsMake(0, self.kj_Padding, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.kj_Padding);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case KJButtonContentLayoutStyleCenterImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -imageWith - self.kj_Padding, 0, imageWith);
            imageEdge = UIEdgeInsetsMake(0, labelWidth + self.kj_Padding, 0, -labelWidth);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case KJButtonContentLayoutStyleCenterImageTop:{
            titleEdge = UIEdgeInsetsMake(0, -imageWith, -imageHeight - self.kj_Padding, 0);
            imageEdge = UIEdgeInsetsMake(-labelHeight - self.kj_Padding, 0, 0, -labelWidth);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case KJButtonContentLayoutStyleCenterImageBottom:{
            titleEdge = UIEdgeInsetsMake(-imageHeight - self.kj_Padding, -imageWith, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, -labelHeight - self.kj_Padding, -labelWidth);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case KJButtonContentLayoutStyleLeftImageLeft:{
            titleEdge = UIEdgeInsetsMake(0, self.kj_Padding + self.kj_PaddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, self.kj_PaddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case KJButtonContentLayoutStyleLeftImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -imageWith + self.kj_PaddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, labelWidth + self.kj_Padding + self.kj_PaddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case KJButtonContentLayoutStyleRightImageLeft:{
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.kj_Padding + self.kj_PaddingInset);
            titleEdge = UIEdgeInsetsMake(0, 0, 0, self.kj_PaddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case KJButtonContentLayoutStyleRightImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -self.frame.size.width / 2, 0, imageWith + self.kj_Padding + self.kj_PaddingInset);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, -labelWidth + self.kj_PaddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        default:break;
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
    [self setNeedsDisplay];
}

#pragma mark - SET
- (void)setKj_ButtonContentLayoutType:(KJButtonContentLayoutStyle)kj_buttonContentLayoutType{
    [self willChangeValueForKey:kButtonContentLayoutTypeKey];
    objc_setAssociatedObject(self, &kButtonContentLayoutTypeKey, @(kj_buttonContentLayoutType), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kButtonContentLayoutTypeKey];
    [self setupButtonLayout];
}

- (KJButtonContentLayoutStyle)kj_ButtonContentLayoutType{
    return [objc_getAssociatedObject(self, &kButtonContentLayoutTypeKey) integerValue];
}

- (void)setKj_Padding:(CGFloat)kj_padding{
    [self willChangeValueForKey:kPaddingKey];
    objc_setAssociatedObject(self, &kPaddingKey, @(kj_padding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kPaddingKey];
    [self setupButtonLayout];
}

- (CGFloat)kj_Padding{
    return [objc_getAssociatedObject(self, &kPaddingKey) floatValue];
}

- (void)setKj_PaddingInset:(CGFloat)kj_paddingInset{
    [self willChangeValueForKey:kPaddingInsetKey];
    objc_setAssociatedObject(self, &kPaddingInsetKey, @(kj_paddingInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kPaddingInsetKey];
    [self setupButtonLayout];
}

- (CGFloat)kj_PaddingInset{
    return [objc_getAssociatedObject(self, &kPaddingInsetKey) floatValue];
}

@end
NS_ASSUME_NONNULL_END

