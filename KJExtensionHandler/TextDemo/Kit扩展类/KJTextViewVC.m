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
    [UITextView kj_openLimitExchangeMethod];
    [UITextView kj_openPlaceHolderExchangeMethod];
    [self.view addSubview:self.remarkTextView];
}

- (UITextView *)remarkTextView{
    if (!_remarkTextView){
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, kScreenW-20, 100)];
        textView.font = [UIFont systemFontOfSize:15];
        
        textView.textAlignment = NSTextAlignmentLeft;
        textView.kj_limitCount = 100;
        textView.kj_limitHeight = 20;
        textView.kj_limitMargin = 10;
        textView.kj_limitLabel.textColor = UIColor.redColor;
        
        textView.kj_placeHolder = @"默认占位符文字";
        textView.kj_placeHolderLabel.textColor = UIColor.redColor;
        
        textView.layer.masksToBounds = YES;
        textView.layer.borderWidth = 1;
        
        _remarkTextView = textView;
    }
    return _remarkTextView;
}

@end
