//
//  UITextView+KJPlaceHolder.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UITextView+KJPlaceHolder.h"
#import <objc/runtime.h>

@interface UITextView ()
@property(nonatomic,readonly)UILabel *kj_placeHolderLabel;
@end
@implementation UITextView (KJPlaceHolder)
+ (void)kj_openPlaceHolderExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")), class_getInstanceMethod(self.class, @selector(kj_placeHolder_layoutSubviews)));
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self.class, @selector(kj_placeHolder_dealloc)));
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")), class_getInstanceMethod(self.class, @selector(kj_placeHolder_setText:)));
    });
}
#pragma mark - swizzled
- (void)kj_placeHolder_dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    [self kj_placeHolder_dealloc];
}
- (void)kj_placeHolder_layoutSubviews{
    if (self.kj_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat x = self.textContainer.lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.kj_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.kj_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self kj_placeHolder_layoutSubviews];
}
- (void)kj_placeHolder_setText:(NSString*)text{
    [self kj_placeHolder_setText:text];
    if (self.kj_placeHolder) [self updatePlaceHolder];
}
#pragma mark - associated
- (NSString*)kj_placeHolder{
    return objc_getAssociatedObject(self, @selector(kj_placeHolder));
}
- (void)setKj_placeHolder:(NSString*)kj_placeHolder{
    objc_setAssociatedObject(self, @selector(kj_placeHolder), kj_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length){
        [self.kj_placeHolderLabel removeFromSuperview];
        return;
    }
    self.kj_placeHolderLabel.font = self.font ? self.font:self.cacutDefaultFont;
    self.kj_placeHolderLabel.textAlignment = self.textAlignment;
    self.kj_placeHolderLabel.text = self.kj_placeHolder;
    [self insertSubview:self.kj_placeHolderLabel atIndex:0];
}
#pragma mark - lazzing
- (UILabel*)kj_placeHolderLabel{
    UILabel *label = objc_getAssociatedObject(self, @selector(kj_placeHolderLabel));
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(kj_placeHolderLabel), label, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return label;
}
- (UIFont*)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
