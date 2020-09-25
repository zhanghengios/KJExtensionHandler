//
//  KJInvertedVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/4/21.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "KJReflectionVC.h"
#import "CALayer+KJReflection.h" // 倒影处理
#import "UIImage+KJReflection.h"
@interface KJReflectionVC (){
    CALayer *reflectionLayer;
    CAGradientLayer *gradientLayer;
}
@property (nonatomic,strong)UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@end

@implementation KJReflectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.imageView.layer.kj_reflectionHideNavigation = NO;//self.fd_prefersNavigationBarHidden = NO;
//    self.imageView.layer.kj_reflectionOpacity = self.slider1.value;
//    self.imageView.layer.kj_reflectionFuzzy = self.slider2.value;
//    self.imageView.layer.kj_reflectionSize = self.slider3.value;
//    self.imageView.layer.kj_reflectionImageSpace = 10.;
//    [self.imageView.layer kj_addReflection];
    self.image = _imageView.image;
    _imageView2.image = [_image reflectionWithAlpha:_slider1.value];
}

- (IBAction)slider1:(UISlider *)sender {
//    self.imageView.layer.kj_reflectionOpacity = sender.value;
    _imageView2.image = [_image reflectionWithAlpha:_slider1.value];
}
- (IBAction)slider2:(UISlider *)sender {
//    self.imageView.layer.kj_reflectionFuzzy = sender.value;
    
}
- (IBAction)slider3:(UISlider *)sender {
//    self.imageView.layer.kj_reflectionSize = sender.value;
    _imageView2.image = [_image reflectionWithHeight:_imageView.frame.size.height*_slider3.value];
}

@end
