//
//  UIButton+KJBlock.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  点击事件ButtonBlock

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol KJButtonTimeExchangeMethodProtocol <NSObject>
@required
/// 是否开启时间间隔的方法交换
+ (void)kj_openTimeExchangeMethod;
@end
typedef void(^KJButtonBlock)(UIButton *kButton);
@interface UIButton (KJBlock)<KJButtonTimeExchangeMethodProtocol>
/// button 添加点击事件，默认UIControlEventTouchUpInside方式
- (void)kj_addAction:(KJButtonBlock)block;
/// button 添加事件 controlEvents 点击的方式
- (void)kj_addAction:(KJButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

/* ******************这两个属性互斥********************/
/// 接受点击事件的时间间隔
@property (nonatomic, assign) NSTimeInterval kj_AcceptEventTime;
/// 接受点击事件执行处理之后的时间间隔
@property (nonatomic, assign) NSTimeInterval kj_AcceptDealTime;
/* ******************这两个属性互斥********************/

@end

NS_ASSUME_NONNULL_END
