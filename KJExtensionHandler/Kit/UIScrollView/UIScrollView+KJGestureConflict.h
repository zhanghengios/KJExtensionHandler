//
//  UIScrollView+KJGestureConflict.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/17.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  滑动冲突处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (KJGestureConflict)
/// 是否需要处理UISlider和UIScrollView的滑动事件冲突
//@property(nonatomic,assign)bool kDelConflict;

@end

NS_ASSUME_NONNULL_END
