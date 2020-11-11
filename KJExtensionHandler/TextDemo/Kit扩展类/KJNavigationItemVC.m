//
//  KJNavigationItemVC.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/10.
//

#import "KJNavigationItemVC.h"

@interface KJNavigationItemVC ()

@end

@implementation KJNavigationItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _weakself;
    [self.navigationItem kj_makeNavigationItem:^(UINavigationItem * _Nonnull make) {
        make.kAddBarButtonItemInfo(^KJNavigationItemInfo * _Nonnull(KJNavigationItemInfo * _Nonnull info) {
            info.imageName = @"wode_nor";
            info.isLeft = NO;
            info.tintColor = UIColor.redColor;
            return info;
        }, ^(UIButton * _Nonnull kButton) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }).kAddBarButtonItemInfo(^KJNavigationItemInfo * _Nonnull(KJNavigationItemInfo * _Nonnull info) {
            info.imageName = @"Arrow";
            info.isLeft = NO;
            info.title = @"测试";
            info.barButton = ^(UIButton * _Nonnull barButton) {
                barButton.kj_ButtonContentLayoutType = KJButtonContentLayoutStyleCenterImageTop;
                barButton.kj_Padding = 2;
            };
            return info;
        }, ^(UIButton * _Nonnull kButton) {
            [weakself.navigationController popViewControllerAnimated:YES];
        });
    }];
}

@end
