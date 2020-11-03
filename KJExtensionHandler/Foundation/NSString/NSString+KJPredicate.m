//
//  NSString+KJPredicate.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/16.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSString+KJPredicate.h"

@implementation NSString (KJPredicate)
//MARK: - 过滤空格
- (NSString*)kj_filterSpace{
    NSString *string = self;
    string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//MARK: - 检测输入内容是否为数字
- (BOOL)kj_validateNumber{
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length){
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0){
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//MARK: - 检测字符串中是否有特殊字符
- (BOOL)kj_validateHaveSpecialCharacter{
    NSString *regex = @".*[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？].*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

//MARK: - 验证手机号码是否有效
- (BOOL)kj_mobileNumberIsCorrect{
    if (self.length != 11) return NO;
    NSString *mo = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    NSString *cm = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    NSString *cu = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    NSString *ct = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    NSPredicate *regexmo = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mo];
    NSPredicate *regexcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cm];
    NSPredicate *regexcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cu];
    NSPredicate *regexct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ct];
    if (([regexmo evaluateWithObject:self] == YES) || ([regexcm evaluateWithObject:self] == YES) || ([regexct evaluateWithObject:self] == YES) || ([regexcu evaluateWithObject:self] == YES)){
        return YES;
    }else{
        return NO;
    }
}

//MARK: - 验证邮箱格式是否正确
- (BOOL)kj_validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//MARK: - 判断身份证是否是真实的
- (BOOL)kj_validateIDCardNumber{
    NSString *value = self;
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!value){
        return NO;
    }else {
        length = value.length;
        if (length != 15 && length != 18) return NO;
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray){
        if ([areaCode isEqualToString:valueStart2]){
            areaFlag = YES;
            break;
        }
    }
    if (areaFlag == NO) return NO;
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    NSInteger year = 0;
    switch (length){
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue + 1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)){
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            return [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)] > 0 ? YES : NO;
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)){
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0){
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue)*7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue)*9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value  substringWithRange:NSMakeRange(12,1)].intValue)*10 + ([value  substringWithRange:NSMakeRange(3,1)].intValue + [value  substringWithRange:NSMakeRange(13,1)].intValue)*5 + ([value  substringWithRange:NSMakeRange(4,1)].intValue + [value  substringWithRange:NSMakeRange(14,1)].intValue)*8 + ([value  substringWithRange:NSMakeRange(5,1)].intValue + [value  substringWithRange:NSMakeRange(15,1)].intValue)*4 + ([value  substringWithRange:NSMakeRange(6,1)].intValue + [value  substringWithRange:NSMakeRange(16,1)].intValue)*2 + [value  substringWithRange:NSMakeRange(7,1)].intValue *1 + [value  substringWithRange:NSMakeRange(8,1)].intValue *6 + [value  substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                return [M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]];
            }else {
                return NO;
            }
        default:
            return NO;
    }
}
/// 随机汉字
+ (NSString*)kj_randomCreatChinese:(NSInteger)count{
    NSMutableString *randomChineseString =@"".mutableCopy;
    for (NSInteger i=0; i < count; i++){
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc]initWithData:data encoding:gbkEncoding];
        [randomChineseString appendString:string];
    }
    return randomChineseString.mutableCopy;
}

@end
