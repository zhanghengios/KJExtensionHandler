//
//  UITextView+KJPlaceHolder.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "UITextView+KJPlaceHolder.h"
#import <objc/runtime.h>

@interface UITextView ()
@property(nonatomic,readonly)UILabel *Label;
@end
@implementation UITextView (KJPlaceHolder)
+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(kj_PlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(kj_PlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(kj_PlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)kj_PlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self kj_PlaceHolder_swizzled_dealloc];
}
- (void)kj_PlaceHolder_swizzling_layoutSubviews {
    if (self.kj_PlaceHolder){
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds)- x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.Label sizeThatFits:CGSizeMake(width, 0)].height;
        self.Label.frame = CGRectMake(x, y, width, height);
    }
    [self kj_PlaceHolder_swizzling_layoutSubviews];
}
- (void)kj_PlaceHolder_swizzled_setText:(NSString *)text{
    [self kj_PlaceHolder_swizzled_setText:text];
    if (self.kj_PlaceHolder) [self updatePlaceHolder];
}
#pragma mark - associated
- (NSString *)kj_PlaceHolder{
    return objc_getAssociatedObject(self, @selector(kj_PlaceHolder));
}
- (void)setKj_PlaceHolder:(NSString *)kj_placeHolder{
    objc_setAssociatedObject(self, @selector(kj_PlaceHolder), kj_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
- (UIColor *)kj_PlaceHolderColor{
    return self.Label.textColor;
}
- (void)setKj_PlaceHolderColor:(UIColor *)kj_placeHolderColor{
    self.Label.textColor = kj_placeHolderColor;
}
#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length){
        [self.Label removeFromSuperview];
        return;
    }
    self.Label.font = self.font ? self.font:self.cacutDefaultFont;
    self.Label.textAlignment = self.textAlignment;
    self.Label.text = self.kj_PlaceHolder;
    [self insertSubview:self.Label atIndex:0];
}
#pragma mark - lazzing
- (UILabel *)Label{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(Label));
    if (!placeHolderLab){
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(Label), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder)name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (UIFont *)cacutDefaultFont{
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
