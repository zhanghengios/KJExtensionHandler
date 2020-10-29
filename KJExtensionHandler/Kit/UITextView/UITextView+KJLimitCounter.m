//
//  UITextView+KJLimitCounter.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UITextView+KJLimitCounter.h"
#import <objc/runtime.h>

@implementation UITextView (KJLimitCounter)
+ (void)kj_openLimitExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")), class_getInstanceMethod(self.class, @selector(kj_limit_layoutSubviews)));
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self.class, @selector(kj_limit_dealloc)));
    });
}
#pragma mark - swizzled
- (void)kj_limit_dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @try {
        [self removeObserver:self forKeyPath:@"layer.borderWidth"];
        [self removeObserver:self forKeyPath:@"text"];
    }@catch (NSException *exception){
    }@finally {
        [self kj_limit_dealloc];
    }
}
- (void)kj_limit_layoutSubviews{
    [self kj_limit_layoutSubviews];
    if (self.kj_limitCount){
        UIEdgeInsets textContainerInset = self.textContainerInset;
        textContainerInset.bottom = self.kj_limitHeight;
        self.contentInset = textContainerInset;
        CGFloat x = CGRectGetMinX(self.frame)+self.layer.borderWidth;
        CGFloat y = CGRectGetMaxY(self.frame)-self.contentInset.bottom-self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds)-self.layer.borderWidth*2;
        CGFloat height = self.kj_limitHeight;
        self.kj_limitLabel.frame = CGRectMake(x, y, width, height);
        if ([self.superview.subviews containsObject:self.kj_limitLabel]) return;
        [self.superview insertSubview:self.kj_limitLabel aboveSubview:self];
    }
}
#pragma mark - associated
- (NSInteger)kj_limitCount{
    return [objc_getAssociatedObject(self, @selector(kj_limitCount)) integerValue];
}
- (void)setKj_limitCount:(NSInteger)kj_limitCount{
    objc_setAssociatedObject(self, @selector(kj_limitCount), @(kj_limitCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}
- (CGFloat)kj_limitMargin{
    return [objc_getAssociatedObject(self, @selector(kj_limitMargin))floatValue];
}
- (void)setKj_limitMargin:(CGFloat)kj_labMargin{
    objc_setAssociatedObject(self, @selector(kj_limitMargin), @(kj_labMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}
- (CGFloat)kj_limitHeight{
    return [objc_getAssociatedObject(self, @selector(kj_limitHeight)) floatValue];
}
- (void)setKj_limitHeight:(CGFloat)kj_labHeight{
    objc_setAssociatedObject(self, @selector(kj_limitHeight), @(kj_labHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}
#pragma mark - config
- (void)_configTextView{
    self.kj_limitHeight = 20;
    self.kj_limitMargin = 10;
}
#pragma mark - update
- (void)updateLimitCount{
    if (self.text.length > self.kj_limitCount){
        UITextRange *markedRange = [self markedTextRange];
        if (markedRange) return;
        NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:self.kj_limitCount];
        self.text = [self.text substringToIndex:range.location];
    }
    NSString *showText = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,(long)self.kj_limitCount];
    self.kj_limitLabel.text = showText;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:showText];
    NSUInteger length = [showText length];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -self.kj_limitMargin;
    style.alignment = NSTextAlignmentRight;
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, length)];
    self.kj_limitLabel.attributedText = attrString;
}
#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id>*)change context:(void*)context{
    if ([keyPath isEqualToString:@"layer.borderWidth"] || [keyPath isEqualToString:@"text"]){
        [self updateLimitCount];
    }
}
#pragma mark - lazzing
- (UILabel *)kj_limitLabel{
    UILabel *label = objc_getAssociatedObject(self, @selector(kj_limitLabel));
    if (label == nil){
        label = [[UILabel alloc] init];
        label.backgroundColor = self.backgroundColor;
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        objc_setAssociatedObject(self, @selector(kj_limitLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLimitCount) name:UITextViewTextDidChangeNotification object:self];
        [self addObserver:self forKeyPath:@"layer.borderWidth" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self _configTextView];
    }
    return label;
}
@end
