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
+ (void)kj_savedPhotosAlbumWithImage:(UIImage*)image Complete:(void(^)(BOOL success))complete;
/// 系统自带分享
+ (UIActivityViewController*)kj_shareActivityWithItems:(NSArray*)items ViewController:(UIViewController*)vc Complete:(void(^)(BOOL success))complete;
/// 切换根视图控制器
+ (void)kj_changeRootViewController:(UIViewController*)vc Complete:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
