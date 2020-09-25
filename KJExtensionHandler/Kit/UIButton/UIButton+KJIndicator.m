//
//  UIButton+KJIndicator.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "UIButton+KJIndicator.h"
#import <objc/runtime.h>

static NSString *const kIndicatorViewKey = @"indicatorView";
static NSString *const kButtonTextObjectKey = @"buttonTextObject";
@interface UIButton ()
@property(nonatomic, strong) UIView *modalView;
@property(nonatomic, strong) UIActivityIndicatorView *spinnerView;
@property(nonatomic, strong) UILabel *spinnerTitleLabel;

@end

@implementation UIButton (KJIndicator)

- (void)kj_showIndicator {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [indicator startAnimating];
    
    NSString *currentButtonText = self.titleLabel.text;
    
    objc_setAssociatedObject(self, &kButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];
}

- (void)kj_hideIndicator {
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &kButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &kIndicatorViewKey);
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
    self.enabled = YES;
}

- (void)kj_beginSubmitting:(NSString*)title{
    [self kj_endSubmitting];
    self.submitting = @YES;
    self.hidden = YES;
    self.modalView = [[UIView alloc] initWithFrame:self.frame];
    self.modalView.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.6];
    self.modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.modalView.layer.borderWidth = self.layer.borderWidth;
    self.modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.modalView.bounds;
    self.spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.spinnerView.tintColor = self.titleLabel.textColor;
    CGRect spinnerViewBounds = self.spinnerView.bounds;
    self.spinnerView.frame = CGRectMake(self.frame.size.width *.5 - spinnerViewBounds.size.width - 10, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2, spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    CGFloat x = CGRectGetMaxX(self.spinnerView.frame) + 5;
    CGRect labelBounds = CGRectMake(x, 0, self.frame.size.width - x - 2, self.frame.size.height);
    self.spinnerTitleLabel = [[UILabel alloc] initWithFrame:labelBounds];
    self.spinnerTitleLabel.text = title;
    self.spinnerTitleLabel.font = self.titleLabel.font;
    self.spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.modalView addSubview:self.spinnerView];
    [self.modalView addSubview:self.spinnerTitleLabel];
    [self.superview addSubview:self.modalView];
    [self.spinnerView startAnimating];
}

- (void)kj_endSubmitting {
    if (!self.isSubmitting.boolValue) return;
    self.submitting = @NO;
    self.hidden = NO;
    
    [self.modalView removeFromSuperview];
    self.modalView = nil;
    self.spinnerView = nil;
    self.spinnerTitleLabel = nil;
}

- (NSNumber*)isSubmitting {
    return objc_getAssociatedObject(self, @selector(setSubmitting:));
}
- (void)setSubmitting:(NSNumber*)submitting {
    objc_setAssociatedObject(self, @selector(setSubmitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIActivityIndicatorView*)spinnerView {
    return objc_getAssociatedObject(self, @selector(setSpinnerView:));
}
- (void)setSpinnerView:(UIActivityIndicatorView*)spinnerView {
    objc_setAssociatedObject(self, @selector(setSpinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView*)modalView {
    return objc_getAssociatedObject(self, @selector(setModalView:));
}
- (void)setModalView:(UIView*)modalView {
    objc_setAssociatedObject(self, @selector(setModalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel*)spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setSpinnerTitleLabel:));
}
- (void)setSpinnerTitleLabel:(UILabel*)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setSpinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
