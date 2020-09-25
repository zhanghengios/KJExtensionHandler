//
//  KJShadowVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/4/13.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "KJShadowVC.h"
#import "KJShadowLayer.h" // 内阴影、外阴影、投影相关
@interface KJShadowVC (){
    KJShadowLayer *layer;
    UIImage *image;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation KJShadowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.imageView layoutIfNeeded];
    image = self.imageView.image;
    layer = [[KJShadowLayer alloc]kj_initWithFrame:self.imageView.bounds ShadowType:(KJShadowTypeInner)];
    layer.kj_shadowPath = [UIBezierPath bezierPathWithRect:self.imageView.bounds];
    layer.kj_shadowOpacity = self.slider1.value;
    layer.kj_shadowRadius = self.slider3.value;
    layer.kj_shadowAngle = self.slider4.value;
    layer.kj_shadowDiffuse = self.slider2.value;
    [self.imageView.layer addSublayer:layer];
    
    _weakself;
    [self.imageView2 kj_AddTapGestureRecognizerBlock:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull gesture) {
        weakself.imageView2.image = [UIImage kj_captureScreen:weakself.imageView];
    }];
}

- (IBAction)slider1:(UISlider *)sender {
    layer.kj_shadowOpacity = self.slider1.value;
}
- (IBAction)slider2:(UISlider *)sender {
    layer.kj_shadowDiffuse = self.slider2.value;
}
- (IBAction)slider3:(UISlider *)sender {
    layer.kj_shadowRadius = self.slider3.value;
}
- (IBAction)slider4:(UISlider *)sender {
    layer.kj_shadowAngle = self.slider4.value;
}

@end
