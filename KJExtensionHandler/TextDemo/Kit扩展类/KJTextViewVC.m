//
//  KJTextViewVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJTextViewVC.h"
#import "UITextView+KJPlaceHolder.h"  // 输入框扩展
#import "UITextView+KJLimitCounter.h" // 限制字数
@interface KJTextViewVC ()

@property(nonatomic,strong)UITextView  *remarkTextView;//备注

@end

@implementation KJTextViewVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.remarkTextView];
}

- (UITextView *)remarkTextView{
    if (!_remarkTextView){
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, kScreenW-20, 100)];
        textView.font = [UIFont systemFontOfSize:14];
        //文字设置居右、placeHolder会跟随设置
        textView.textAlignment = NSTextAlignmentLeft;
        textView.kj_LimitCount = 50;
        textView.kj_LabHeight = 12;
        textView.kj_LabMargin = 5;
        textView.kj_LabFont = [UIFont systemFontOfSize:12];
        
        textView.kj_PlaceHolder = @"默认PlaceHolder文字";
        textView.kj_PlaceHolderColor = UIColor.blueColor;
        
        textView.layer.masksToBounds = YES;
        textView.layer.borderWidth = 1;
        
        _remarkTextView = textView;
    }
    return _remarkTextView;
}

@end
