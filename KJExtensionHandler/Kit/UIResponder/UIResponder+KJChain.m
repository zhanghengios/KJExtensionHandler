//
//  UIResponder+KJChain.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/26.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIResponder+KJChain.h"
@implementation UIResponder (KJChain)
static __weak id currentFirstResponder;
- (NSString*)kChainDescription{
    NSMutableArray *temps = [NSMutableArray array];
    [temps addObject:[self class]];
    UIResponder *nextResponder = self;
    while ((nextResponder = [nextResponder nextResponder])) {
        [temps addObject:[nextResponder class]];
    }
    __block NSString *returnString = @"Responder Chain:\n";
    __block int index = 0;
    [temps enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (index) {
            returnString = [returnString stringByAppendingString:@"|"];
            for (int i = 0; i < index; i++) {
                returnString = [returnString stringByAppendingString:@"----"];
            }
            returnString = [returnString stringByAppendingString:@" "];
        }else {
            returnString = [returnString stringByAppendingString:@"| "];
        }
        returnString = [returnString stringByAppendingFormat:@"%@ (%@)\n", obj, @(idx)];
        index++;
    }];
    return returnString;
}
- (id)kFirstResponder{
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}
- (void)findCurrentFirstResponder:(id)sender{
    currentFirstResponder = self;
}
- (UIResponder *)kj_responderWithClass:(Class)clazz {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:clazz]) {
            return responder;
        }
    }return nil;
}

- (BOOL)kj_sendAction:(SEL)action Sender:(id)sender {
    id target = sender;
    while (target && ![target canPerformAction:action withSender:sender]) {
        target = [target nextResponder];
    }
    if (!target) return NO;
    return [[UIApplication sharedApplication] sendAction:action to:target from:sender forEvent:nil];
}

@end
