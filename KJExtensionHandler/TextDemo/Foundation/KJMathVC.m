//
//  KJMathVC.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/31.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJMathVC.h"
#import "NSObject+KJMath.h"

@interface KJMathVC ()
@property (weak, nonatomic) IBOutlet UITextField *k;
@property (weak, nonatomic) IBOutlet UITextField *b;
@property (weak, nonatomic) IBOutlet UITextField *x1;
@property (weak, nonatomic) IBOutlet UITextField *y1;
@property (weak, nonatomic) IBOutlet UITextField *x2;
@property (weak, nonatomic) IBOutlet UITextField *y2;

@end

@implementation KJMathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = UIColor.blackColor;
    
    test(249);
}
- (IBAction)kb:(UIButton *)sender {
    [NSObject kj_mathOnceLinearEquationWithPointA:KJMathPointMake([self.x1.text floatValue],[self.y1.text floatValue]) PointB:KJMathPointMake([self.x2.text floatValue],[self.y2.text floatValue])];
    self.k.text = [NSString stringWithFormat:@"%.2f",NSObject.kj_k];
    self.b.text = [NSString stringWithFormat:@"%.2f",NSObject.kj_b];
}
- (IBAction)x:(id)sender {
    NSObject.kj_k = [self.k.text floatValue];
    NSObject.kj_b = [self.b.text floatValue];
    CGFloat x = [NSObject kj_xValueWithY:[self.y1.text floatValue]];
    self.x1.text = [NSString stringWithFormat:@"%.2f",x];
}
- (IBAction)y:(id)sender {
    NSObject.kj_k = [self.k.text floatValue];
    NSObject.kj_b = [self.b.text floatValue];
    CGFloat y = [NSObject kj_yValueWithX:[self.x2.text floatValue]];
    self.y2.text = [NSString stringWithFormat:@"%.2f",y];
}

/// 写一个函数，输入数字如38，拆分3*8=24，2*4=8，最后8不能拆分则返回
static inline int test(int num){
    NSString *numString = [NSString stringWithFormat:@"%d",num];
    if (numString.length < 2) return num;
    int last  = [numString substringFromIndex:numString.length-1].intValue;
    int start = [numString substringToIndex:numString.length-1].intValue;
    NSLog(@"拆开的结果：%d * %d = %d",start,last,last * start);
    return test(last * start);
}

@end
