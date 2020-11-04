//
//  NSString+KJChinese.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSString+KJChinese.h"

@implementation NSString (KJChinese)
/// 汉字转拼音
- (NSString*)pinYin{
    //先转换为带声调的拼音
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformStripDiacritics,NO);
    return str;
}
/// 随机汉字
+ (NSString*)kj_randomCreateChinese:(NSInteger)count{
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
/// 文字转图片
+ (UIImage*)kj_imageFromText:(NSArray*)contents ContentWidth:(CGFloat)width Font:(UIFont*)font TextColor:(UIColor*)textColor BgColor:(UIColor*)bgColor{
    NSMutableArray *temps = [[NSMutableArray alloc] initWithCapacity:contents.count];
    CGFloat height = 0.0f;
    for (NSString *sContent in contents) {
        CGSize stringSize = [sContent boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        [temps addObject:[NSNumber numberWithFloat:stringSize.height]];
        height += stringSize.height;
    }
    CGSize newSize = CGSizeMake(width, height+10);
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if(bgColor){
        [bgColor set];
        UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
    }
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFillClip);
    [textColor set];
    int index = 0;
    CGFloat y = 10.0f;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dict = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraph};
    for (NSString *sContent in contents) {
        NSNumber *numHeight = [temps objectAtIndex:index];
        CGRect rect = CGRectMake(0, y, width, [numHeight floatValue]);
        [sContent drawInRect:rect withAttributes:dict];
        y += [numHeight floatValue];
        index++;
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
