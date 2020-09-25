//
//  BaseViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "BaseViewController.h"
#import "UIBarButtonItem+KJExtension.h" // 设置BarButtonItem
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromHEXA(0xf5f5f5, 1);
    /// 去掉返回文字
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem kj_ItemWithImage:@"Arrow" HighImage:@"" Title:@"" TitleColor:UIColor.clearColor Target:self Action:@selector(back)];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    // 只要控制器执行此方法，代表VC以及其控件全部已安全从内存中撤出。
    // ARC除去了手动管理内存，但不代表能控制循环引用，虽然去除了内存销毁概念，但引入了新的概念--对象被持有。
    // 框架在使用后能完全从内存中销毁才是最好的优化
    // 不明白ARC和内存泄漏的请自行谷歌，此示例已加入内存检测功能，如果有内存泄漏会alent进行提示
    NSLog(@"控制器%s调用情况，已销毁%@",__func__,self);
}

@end
