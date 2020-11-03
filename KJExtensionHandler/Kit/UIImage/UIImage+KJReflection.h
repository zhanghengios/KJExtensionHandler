//
//  UIImage+KJReflection.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/25.
//  Copyright © 2020 杨科军. All rights reserved.
//  来源作者：https://github.com/unixpickle/ImageReflection
//  倒影

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJReflection)
///
- (UIImage*)reflectionWithHeight:(int)height;

- (UIImage*)reflectionWithAlpha:(float)pcnt;

- (UIImage*)reflectionRotatedWithAlpha:(float)pcnt;

@end

NS_ASSUME_NONNULL_END
