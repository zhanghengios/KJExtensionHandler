//
//  UIImage+KJCompress.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/4/20.
//  Copyright © 2020 杨科军. All rights reserved.
//  图片压缩拼接处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJCompress)
#pragma mark - 压缩图片处理
/// 压缩图片到指定大小
- (UIImage*)kj_compressTargetByte:(NSUInteger)maxLength;
/// 压缩图片到指定大小
+ (UIImage*)kj_compressImage:(UIImage*)image TargetByte:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
