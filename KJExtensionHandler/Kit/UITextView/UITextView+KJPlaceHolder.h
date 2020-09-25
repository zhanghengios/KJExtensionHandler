//
//  UITextView+KJPlaceHolder.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UITextView (KJPlaceHolder)

@property(nonatomic,copy)NSString *kj_PlaceHolder;
/// placeHolder颜色
@property(nonatomic,strong)UIColor *kj_PlaceHolderColor;

@end
NS_ASSUME_NONNULL_END
