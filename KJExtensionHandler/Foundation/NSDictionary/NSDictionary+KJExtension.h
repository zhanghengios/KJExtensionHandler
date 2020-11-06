//
//  NSDictionary+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (KJExtension)
/// 是否为空
@property(nonatomic,assign,readonly)bool isEmpty;
/// 转换为Josn字符串
@property(nonatomic,strong,readonly)NSString *jsonString;

@end

NS_ASSUME_NONNULL_END
