//
//  NSString+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSString+KJExtension.h"

@implementation NSString (KJExtension)
/// 是否为空
- (bool)isEmpty{
    if (self == nil || self == NULL || [self isKindOfClass:[NSNull class]] || [self length] == 0 || [self isEqualToString: @"(null)"]) {
        return true;
    }
    return false;
}
/// 转换为URL
- (NSURL*)URL{ return [NSURL URLWithString:self];}
/// 获取图片
- (UIImage*)image{ return [UIImage imageNamed:self];}
/// 取出HTML
- (NSString*)HTMLString{
    if (self == nil) return nil;
    NSString *html = self;
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd] == NO){
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
- (NSDictionary*)jsonDict{
    if (self == nil) return nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return nil;
    return dic;
}
@end
