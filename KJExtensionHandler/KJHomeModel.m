//
//  KJHomeModel.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/16.
//

#import "KJHomeModel.h"

@implementation KJHomeModel
- (instancetype)init{
    if (self==[super init]) {
        self.sectionTemps = @[@"Kit扩展类",@"效果类",@"Foundation扩展类"];
    }
    return self;
}
#pragma mark - lazy
- (NSArray*)temps{
    if (!_temps) {
        NSMutableArray *temp1 = [NSMutableArray array];
        [temp1 addObject:@{@"VCName":@"KJButtonVC",@"describeName":@"Button图文布局点赞粒子"}];
        [temp1 addObject:@{@"VCName":@"KJLabelVC",@"describeName":@"Label文本位置管理"}];
        [temp1 addObject:@{@"VCName":@"KJViewVC",@"describeName":@"View快速切圆角边框"}];
        [temp1 addObject:@{@"VCName":@"KJGestureVC",@"describeName":@"Gesture手势相关处理"}];
        [temp1 addObject:@{@"VCName":@"KJSliderVC",@"describeName":@"Slider渐变色滑块"}];
        [temp1 addObject:@{@"VCName":@"KJTextViewVC",@"describeName":@"TextView设置限制字数"}];
        [temp1 addObject:@{@"VCName":@"KJCollectionVC",@"describeName":@"CollectView滚动处理"}];
        [temp1 addObject:@{@"VCName":@"KJToastVC",@"describeName":@"Toast处理"}];
                                                                                                                             
        NSMutableArray *temp0 = [NSMutableArray array];
        [temp0 addObject:@{@"VCName":@"KJFloodImageVC",@"describeName":@"Image填充同颜色区域"}];
        [temp0 addObject:@{@"VCName":@"KJImageVC",@"describeName":@"Image加水印和拼接"}];
        [temp0 addObject:@{@"VCName":@"KJCoreImageVC",@"describeName":@"CoreImage框架相关"}];
        [temp0 addObject:@{@"VCName":@"KJReflectionVC",@"describeName":@"倒影处理"}];
        [temp0 addObject:@{@"VCName":@"KJShadowVC",@"describeName":@"内阴影相关"}];
        [temp0 addObject:@{@"VCName":@"KJShineVC",@"describeName":@"内发光处理"}];
        [temp0 addObject:@{@"VCName":@"KJFilterImageVC",@"describeName":@"滤镜相关和特效渲染"}];
        
        NSMutableArray *temp2 = [NSMutableArray array];
        [temp2 addObject:@{@"VCName":@"KJMathVC",@"describeName":@"数学方程式"}];
        
        _temps = @[temp1,temp0,temp2];
    }
    return _temps;
}

@end
