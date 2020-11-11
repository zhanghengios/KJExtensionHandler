//
//  UIBezierPath+KJPoints.h
//  AutoDecorate
//
//  Created by 杨科军 on 2020/7/8.
//  Copyright © 2020 songxf. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  获取贝塞尔曲线上面的点

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (KJPoints)
/// 获取所有点
@property(nonatomic,strong,readonly)NSArray *points;

@end

NS_ASSUME_NONNULL_END
