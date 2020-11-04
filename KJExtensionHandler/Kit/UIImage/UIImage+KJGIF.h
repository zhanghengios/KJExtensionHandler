//
//  UIImage+KJGIF.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  来源作者：https://github.com/mayoff/uiimage-from-animated-gif
//  播放动态图

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJGIF)

/// 本地动图
+ (UIImage*)kj_gifImageWithData:(NSData*)data;
/// 网络动图
+ (UIImage*)kj_gifImageWithURL:(NSURL*)URL;

@end

NS_ASSUME_NONNULL_END
