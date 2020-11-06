//
//  NSDictionary+KJExtension.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/6.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSDictionary+KJExtension.h"

@implementation NSDictionary (KJExtension)
- (bool)isEmpty{
    return (self == nil || [self isKindOfClass:[NSNull class]] || self.allKeys == 0);
}
- (NSString*)jsonString{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
