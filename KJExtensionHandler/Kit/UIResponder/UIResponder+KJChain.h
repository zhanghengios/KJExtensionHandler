//
//  UIResponder+KJChain.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/26.
//  https://github.com/yangKJ/KJExtensionHandler
//  响应链处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (KJChain)
/// 响应链详情
@property(nonatomic,strong,readonly)NSString *kChainDescription;
/// 第一响应者
@property(nonatomic,strong,readonly)id kFirstResponder;
@end

NS_ASSUME_NONNULL_END
