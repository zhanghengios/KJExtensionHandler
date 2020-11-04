//
//  UIImage+KJJoint.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler
//  图片拼接相关处理

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJJoint)
/// 追加宽高属性，用户设置并非图片真实宽高
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat x,y;
#pragma mark - 图片拼接
/// 竖直方向拼接随意张图片，固定主图的宽度
- (UIImage*)kj_moreJointVerticalImage:(UIImage*)jointImage,...;
/// 水平方向拼接随意张图片，固定主图的高度
- (UIImage*)kj_moreJointLevelImage:(UIImage*)jointImage,...;
/// 图片多次合成处理
- (UIImage*)kj_imageCompoundWithLoopNums:(NSInteger)loopTimes Orientation:(UIImageOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
