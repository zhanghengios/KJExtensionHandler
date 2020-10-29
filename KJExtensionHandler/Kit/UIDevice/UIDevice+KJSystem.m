//
//  UIDevice+KJSystem.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/23.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIDevice+KJSystem.h"
#import <objc/runtime.h>
@implementation UIDevice (KJSystem)
+ (void(^)(void))FailBlock{
    return objc_getAssociatedObject(self, @selector(FailBlock));
}
+ (void)setFailBlock:(void(^)(void))FailBlock{
    objc_setAssociatedObject(self, @selector(FailBlock), FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void(^)(void))CompleteBlock{
    return objc_getAssociatedObject(self, @selector(CompleteBlock));
}
+ (void)setCompleteBlock:(void(^)(void))CompleteBlock{
    objc_setAssociatedObject(self, @selector(CompleteBlock), CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 保存到相册
+ (void)kj_savedPhotosAlbumWithImage:(UIImage*)image Complete:(void(^)(void))complete Fail:(void(^)(void))fail{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
    self.CompleteBlock = complete;
    self.FailBlock = fail;
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void *)contextInfo{
    if(error == nil){
        if(UIDevice.CompleteBlock != nil) UIDevice.CompleteBlock();
    }else{
        if(UIDevice.FailBlock != nil) UIDevice.FailBlock();
    }
}


@end
