//
//  KJShadowVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/4/13.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "KJShineVC.h"
#import "KJShadowLayer.h" // 内阴影、外阴影、投影相关
@interface KJShineVC (){
   __block KJShadowLayer *layer;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UILabel *xLabel;

@end

@implementation KJShineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.imageView layoutIfNeeded];
    layer = [[KJShadowLayer alloc]kj_initWithFrame:self.imageView.bounds ShadowType:(KJShadowTypeInnerShine)];
    layer.kj_shadowPath = [UIBezierPath bezierPathWithRect:self.imageView.bounds];
    layer.kj_shadowColor = UIColor.redColor;
    layer.kj_shadowOpacity = self.slider1.value;
    layer.kj_shadowDiffuse = self.slider2.value;
    layer.kj_shadowRadius = self.slider3.value;
    [self.imageView.layer addSublayer:layer];
    layer.contents = self.imageView.image;
    
    _weakself;
    for (UIView *view in self.view.subviews) {
        if (520<=view.tag&&view.tag<=523) {
            [view kj_AddTapGestureRecognizerBlock:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull gesture) {
                layer.kj_shadowColor = view.backgroundColor;
                weakself.displayImageView.image = [UIImage kj_captureScreen:weakself.imageView];
            }];
        }
    }
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

@end
