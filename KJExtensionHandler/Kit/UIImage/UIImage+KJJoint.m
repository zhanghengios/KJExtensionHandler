//
//  UIImage+KJJoint.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//

#import "UIImage+KJJoint.h"

@implementation UIImage (KJJoint)
/// 随意张拼接图片
- (UIImage*)kj_moreJointVerticalImage:(UIImage*)jointImage,...{
    NSMutableArray<UIImage*>* temps = [NSMutableArray arrayWithObjects:self,jointImage,nil];
    CGSize size = self.size;
    CGFloat w = size.width;
    size.height += w*jointImage.size.height/jointImage.size.width;
    
    va_list args;UIImage *tempImage;
    va_start(args, jointImage);
    while ((tempImage = va_arg(args, UIImage*))) {
        size.height += w*tempImage.size.height/tempImage.size.width;
        [temps addObject:tempImage];
    }
    va_end(args);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGFloat y = 0;
    for (UIImage *img in temps) {
        CGFloat h = w*img.size.height/img.size.width;
        [img drawInRect:CGRectMake(0, y, w, h)];
        y += h;
    }
//    __block NSInteger index = 0;
//    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    for (UIImage *img in temps) {
//        kGCD_async(^{
//            @synchronized (@(index)) {
//                kGCD_main(^{
//                    [img drawInRect:CGRectMake(0, img.y, w, img.height)];
//                });
//                index++;
//                NSLog(@"---%ld,%f,%f",index,img.y,img.height);
//                if (index == temps.count) {
//                    dispatch_semaphore_signal(sem);
//                }
//            }
//        });
//    }
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
/// 水平方向拼接随意张图片
- (UIImage*)kj_moreJointLevelImage:(UIImage*)jointImage,...{
    NSMutableArray<UIImage*>* temps = [NSMutableArray arrayWithObjects:self,jointImage,nil];
    CGSize size = self.size;
    CGFloat h = size.height;
    size.width += h*jointImage.size.width/jointImage.size.height;
    
    va_list args;UIImage *tempImage;
    va_start(args, jointImage);
    while ((tempImage = va_arg(args, UIImage*))) {
        size.width += h*tempImage.size.width/tempImage.size.height;
        [temps addObject:tempImage];
    }
    va_end(args);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGFloat x = 0;
    for (UIImage *img in temps) {
        CGFloat w = h*img.size.width/img.size.height;
        [img drawInRect:CGRectMake(x, 0, w, h)];
        x += w;
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
/// 图片多次合成处理
- (UIImage*)kj_imageCompoundWithLoopNums:(NSInteger)loopNums Orientation:(UIImageOrientation)orientation{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGFloat X = 0,Y = 0;
    switch (orientation) {
        case UIImageOrientationUp:
            for (int i = 0; i < loopNums; i++) {
                CGFloat W = self.size.width / loopNums;
                CGFloat H = self.size.height;
                X = W * i;
                [self drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        case UIImageOrientationLeft:
            for (int i = 0; i < loopNums; i++) {
                CGFloat W = self.size.width;
                CGFloat H = self.size.height / loopNums;
                Y = H * i;
                [self drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        case UIImageOrientationRight:
            for (int i = 0; i < loopNums; i++) {
                CGFloat W = self.size.width;
                CGFloat H = self.size.height / loopNums;
                Y = H * i;
                [self drawInRect:CGRectMake(X, Y, W, H)];
            }
            break;
        default:
            break;
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark - setter/getter
- (CGFloat)x{
    return [objc_getAssociatedObject(self, @selector(x)) floatValue];
}
- (void)setX:(CGFloat)x{
    objc_setAssociatedObject(self, @selector(x), @(x), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)y{
    return [objc_getAssociatedObject(self, @selector(y)) floatValue];
}
- (void)setY:(CGFloat)y{
    objc_setAssociatedObject(self, @selector(y), @(y), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)width{
    return [objc_getAssociatedObject(self, @selector(width)) floatValue];
}
- (void)setWidth:(CGFloat)width{
    objc_setAssociatedObject(self, @selector(width), @(width), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)height{
    return [objc_getAssociatedObject(self, @selector(height)) floatValue];
}
- (void)setHeight:(CGFloat)height{
    objc_setAssociatedObject(self, @selector(height), @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
