//
//  UIDevice+KJSystem.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/23.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIDevice+KJSystem.h"
#import <objc/runtime.h>
#import "UIView+KJXib.h"
@implementation UIDevice (KJSystem)
+ (void(^)(BOOL success))completeBlock{
    return objc_getAssociatedObject(self, @selector(completeBlock));
}
+ (void)setCompleteBlock:(void(^)(BOOL success))completeBlock{
    objc_setAssociatedObject(self, @selector(completeBlock), completeBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 保存到相册
+ (void)kj_savedPhotosAlbumWithImage:(UIImage*)image Complete:(void(^)(BOOL success))complete{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    self.completeBlock = complete;
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (UIDevice.completeBlock) {
        UIDevice.completeBlock(error == nil?YES:NO);
    }
}
/// 系统自带分享
+ (UIActivityViewController*)kj_shareActivityWithItems:(NSArray*)items ViewController:(UIViewController*)vc Complete:(void(^)(BOOL success))complete{
    if (items.count == 0) return nil;
    UIActivityViewController *__vc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    if (@available(iOS 11.0, *)) {
        __vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypeOpenInIBooks, UIActivityTypeMarkupAsPDF];
    }else if (@available(iOS 9.0, *)) {
        __vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypeOpenInIBooks];
    }else {
        __vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail];
    }
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (complete) complete(completed);
    };
    __vc.completionWithItemsHandler = itemsBlock;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        __vc.popoverPresentationController.sourceView = vc.view;
        __vc.popoverPresentationController.sourceRect = CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height, 0, 0);
    }
    [vc presentViewController:__vc animated:YES completion:nil];
    return __vc;
}
/// 切换根视图控制器
+ (void)kj_changeRootViewController:(UIViewController*)vc Complete:(void(^)(BOOL success))complete{
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        [UIView setAnimationsEnabled:oldState];
    }completion:^(BOOL finished) {
        if (complete) complete(finished);
    }];
}
/// 跳转到设置
+ (void)kj_{
    if (UIApplicationOpenSettingsURLString != NULL) {
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:URL options:@{} completionHandler:nil];
        }
    }
}

@end
