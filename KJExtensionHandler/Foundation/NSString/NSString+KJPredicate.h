//
//  NSString+KJPredicate.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/16.
//  https://github.com/yangKJ/KJExtensionHandler
//  谓词工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJPredicate)
/// 过滤空格
- (NSString*)kj_filterSpace;
/// 检测输入内容是否为数字
- (BOOL)kj_validateNumber;
/// 验证字符串中是否有特殊字符
- (BOOL)kj_validateHaveSpecialCharacter;
/// 验证手机号码是否有效
- (BOOL)kj_mobileNumberIsCorrect;
/// 验证邮箱格式是否正确
- (BOOL)kj_validateEmail;
/// 验证身份证是否是真实的
- (BOOL)kj_validateIDCardNumber;

@end

NS_ASSUME_NONNULL_END
