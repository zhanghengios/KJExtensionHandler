//
//  UIImage+KJURLSize.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  来源作者：https://github.com/90candy/GetImageSizeWithURL
//  获取网络图片尺寸

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJURLSize)
/// 获取网络图片尺寸
+ (CGSize)kj_imageGetSizeWithURL:(NSURL*)URL;

//UITableViewCell里面浏览的时候卡顿解决方案：
//在拿到需要请求的url数组的时候，就将每个链接的尺寸顺便就给获取出来，然后本地化存储该图片的尺寸，然后再到UITableViewCell里面根据链接直接在本地取到图片的尺寸
//if (![[NSUserDefaults standardUserDefaults] objectForKey:url]) {
//    CGSize imageSize = [UIImage getImageSizeWithURL:url];
//    CGFloat imgH = 0;
//    if (imageSize.height > 0) {
//        imgH = imageSize.height * (SCREEN_WIDTH - 2 * _spaceX) / imageSize.width;
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:@(imgH) forKey:url];
//}

@end

NS_ASSUME_NONNULL_END
