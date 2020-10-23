//
//  UIImage+KJBlur.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/23.
//  毛玻璃效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJBlur)

- (UIImage*)imageByBlurSoft;

- (UIImage*)imageByBlurLight;

- (UIImage*)imageByBlurExtraLight;

- (UIImage*)imageByBlurDark;

- (UIImage*)imageByBlurWithTint:(UIColor *)tintColor;

- (UIImage*)imageByBlurRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor tintMode:(CGBlendMode)tintBlendMode saturation:(CGFloat)saturation maskImage:(UIImage *)maskImage;

- (UIImage*)boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
@end

NS_ASSUME_NONNULL_END
