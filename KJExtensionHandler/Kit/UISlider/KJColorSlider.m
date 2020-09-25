//
//  KJColorSlider.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/8/24.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "KJColorSlider.h"
#import "UIColor+KJExtension.h"
@interface KJColorSlider()
@property(nonatomic,strong) UIImageView *backImageView;
@property(nonatomic,assign) NSTimeInterval lastTime;
@end

@implementation KJColorSlider
#pragma mark - public method
- (void)kj_setUI{ [self drawNewImage];}

#pragma mark - system method
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (CGRectEqualToRect(self.backImageView.frame, CGRectZero)) {
        CGRect imgViewFrame = self.backImageView.frame;
        imgViewFrame.size.width = self.frame.size.width;
        imgViewFrame.size.height = _colorHeight;
        imgViewFrame.origin.y = (self.frame.size.height - _colorHeight) * 0.5;
        self.backImageView.frame = imgViewFrame;
        [self drawNewImage];
    }
}

#pragma mark - private method
- (void)drawNewImage{
    self.backImageView.image = [UIColor kj_colorImageWithColors:_colors locations:_locations size:CGSizeMake(self.frame.size.width, _colorHeight) borderWidth:_borderWidth borderColor:_borderColor];
}
- (void)setup{
    self.colors = @[UIColor.whiteColor];
    self.locations = @[@(1.)];
    self.colorHeight = 2.5;
    self.borderWidth = 0.0;
    self.borderColor = UIColor.blackColor;
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.backImageView];
    [self sendSubviewToBack:self.backImageView];
    self.tintColor = [UIColor clearColor];
    self.maximumTrackTintColor = self.minimumTrackTintColor = [UIColor clearColor];
    [self addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(endMove) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(endMove) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(touchCancel) forControlEvents:UIControlEventTouchCancel];
}
- (void)valueChange{
    if (self.kValueChangeBlock) {
        if (_timeSpan == 0) {
            self.kValueChangeBlock(self.value);
        }else if (CFAbsoluteTimeGetCurrent() - self.lastTime > _timeSpan) {
            _lastTime = CFAbsoluteTimeGetCurrent();
            self.kValueChangeBlock(self.value);
        }
    }
}
- (void)endMove{
    if (self.kMoveEndBlock) {
        self.kMoveEndBlock(self.value);
        return;
    }
    if (self.kValueChangeBlock) self.kValueChangeBlock(self.value);
}
- (void)touchCancel{
    if (self.kMoveEndBlock) self.kMoveEndBlock(self.value);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
