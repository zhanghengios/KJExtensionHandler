//
//  UIDevice+KJSystem.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/23.
//  https://github.com/yangKJ/KJExtensionHandler
//  系统相关的操作

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIDevice (KJSystem)
/// 保存到相册
+ (void)kj_savedPhotosAlbumWithImage:(UIImage*)image Complete:(void(^)(void))complete Fail:(void(^)(void))fail;

@end

NS_ASSUME_NONNULL_END
