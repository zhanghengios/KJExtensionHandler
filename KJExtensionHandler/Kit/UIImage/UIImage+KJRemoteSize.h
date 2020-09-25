//
//  UIImage+KJRemoteSize.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  获取网络图片尺寸

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^kImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);
@interface UIImage (KJRemoteSize)
/** 获取远程图片的大小
 *  @param imgURL     图片url
 *  @param completion 完成回调
 */
+ (void)kj_requestSizeNoHeader:(NSURL*)imgURL completion:(kImageSizeRequestCompleted)completion;

@end

NS_ASSUME_NONNULL_END
