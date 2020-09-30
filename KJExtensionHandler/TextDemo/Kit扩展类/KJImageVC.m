//
//  KJIMageVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/8/22.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJImageVC.h"

@interface KJImageVC ()
@property (weak, nonatomic) IBOutlet UIImageView *Image1;
@property (weak, nonatomic) IBOutlet UIImageView *Image2;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UIButton *Button;
@property (weak, nonatomic) IBOutlet UIButton *Button2;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView2;
@end

@implementation KJImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _weakself;
    self.Button.kj_AcceptEventTime = 3;
    [self.Button kj_addAction:^(UIButton * _Nonnull kButton) {
        UIImage *textImage = [UIImage kj_imageFromText:@[@"水印文字"] ContentWidth:weakself.Image1.size.width Font:[UIFont systemFontOfSize:50] TextColor:UIColor.redColor BgColor:nil];
        UIImage *image = [weakself.Image1.image kj_waterMark:textImage InRect:CGRectMake(0, weakself.Image1.size.height-50, weakself.Image1.size.width, 50)];
        weakself.ImageView.image = image;
    }];
    self.Button2.kj_AcceptDealTime = 5;
    [self.Button2 kj_addAction:^(UIButton * _Nonnull kButton) {
        CGFloat wd = MAX(weakself.Image2.image.size.width, weakself.Image2.image.size.height);
        /// 裁剪图片
        UIImage *img = [UIImage kj_cutImageWithImage:weakself.Image2.image Frame:CGRectMake(0, 0, wd, wd)];
        /// 旋转图片
        UIImage *image = [weakself.Image2.image kj_rotateInRadians:M_PI];
        /// 拼接图片
        weakself.ImageView2.image = [weakself.Image1.image kj_jointImageWithHeadImage:img FootImage:image];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
