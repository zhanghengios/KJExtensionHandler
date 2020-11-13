//
//  BaseViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "BaseViewController.h"
//#import "UIBarButtonItem+KJExtension.h" // 设置BarButtonItem
#import "UIDevice+KJSystem.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromHEXA(0xf5f5f5, 1);

    _weakself;
    [self.navigationItem kj_makeNavigationItem:^(UINavigationItem * _Nonnull make) {
        make.kAddBarButtonItemInfo(^KJNavigationItemInfo * _Nonnull(KJNavigationItemInfo * _Nonnull info) {
            info.imageName = @"Arrow";
            info.tintColor = UIColor.whiteColor;
            return info;
        }, ^(UIButton * _Nonnull kButton) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }).kAddBarButtonItemInfo(^KJNavigationItemInfo * _Nonnull(KJNavigationItemInfo * _Nonnull info) {
            info.imageName = @"wode_nor";
            info.isLeft = NO;
            info.tintColor = UIColor.redColor;
            return info;
        }, ^(UIButton * _Nonnull kButton) {
            [weakself.navigationController popViewControllerAnimated:YES];
        });
        make.kAddBarButtonItemInfo(^KJNavigationItemInfo * _Nonnull(KJNavigationItemInfo * _Nonnull info) {
            info.title = @"分享";
            info.isLeft = NO;
            return info;
        }, ^(UIButton * _Nonnull kButton) {
            UIImage *image = [UIImage kj_captureScreen:weakself.view Rect:CGRectMake(0, kSTATUSBAR_NAVIGATION_HEIGHT, kScreenW, kScreenH-kSTATUSBAR_NAVIGATION_HEIGHT)];
            [UIDevice kj_shareActivityWithItems:@[UIImagePNGRepresentation(image)] ViewController:weakself Complete:^(BOOL success) {
                [weakself.navigationController.view makeToast:success?@"分享成功":@"分享失败"];
            }];
        });
    }];
}

- (void)dealloc{
    // 只要控制器执行此方法，代表VC以及其控件全部已安全从内存中撤出。
    // ARC除去了手动管理内存，但不代表能控制循环引用，虽然去除了内存销毁概念，但引入了新的概念--对象被持有。
    // 框架在使用后能完全从内存中销毁才是最好的优化
    // 不明白ARC和内存泄漏的请自行谷歌，此示例已加入内存检测功能，如果有内存泄漏会alent进行提示
    NSLog(@"控制器%s调用情况，已销毁%@",__func__,self);
}

@end
