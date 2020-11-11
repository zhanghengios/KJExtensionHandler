//
//  KJLabelVC.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/11.
//

#import "KJLabelVC.h"

@interface KJLabelVC ()

@end

@implementation KJLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat x,y;
    CGFloat sp = kAutoW(10);
    CGFloat w = (kScreenW-sp*4)/3.;
    CGFloat h = w*9/16;
    NSArray *name = @[@"左边",@"右边",@"中间",@"左上",@"右上",@"左下",@"右下",@"中上",@"中下"];
    for (int k=0; k<name.count; k++) {
        x = k%3*(w+sp)+sp;
        y = k/3*(h+sp)+sp+64+sp*2;
        UILabel *label = [UILabel kj_createLabelWithText:name[k] FontSize:16 TextColor:UIColor.orangeColor];
        label.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.2];
        label.kTextAlignmentType = [self kj_index:k];
        label.borderWidth = 1;
        label.borderColor = UIColor.orangeColor;
        label.frame = CGRectMake(x, y, w, h);
        [self.view addSubview:label];
    }
}
- (KJLabelTextAlignmentType)kj_index:(NSInteger)index{
    if (index == 0) {
        return KJLabelTextAlignmentTypeLeft;
    }else if (index == 1) {
        return KJLabelTextAlignmentTypeRight;
    }else if (index == 2) {
        return KJLabelTextAlignmentTypeCenter;
    }else if (index == 3) {
        return KJLabelTextAlignmentTypeLeftTop;
    }else if (index == 4) {
        return KJLabelTextAlignmentTypeRightTop;
    }else if (index == 5) {
        return KJLabelTextAlignmentTypeLeftBottom;
    }else if (index == 6) {
        return KJLabelTextAlignmentTypeRightBottom;
    }else if (index == 7) {
        return KJLabelTextAlignmentTypeTopCenter;
    }else {
        return KJLabelTextAlignmentTypeBottomCenter;
    }
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
