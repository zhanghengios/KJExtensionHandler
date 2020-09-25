//
//  UIView+KJXib.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE // 动态刷新 在类名前加上此宏定义，初始化、布置和绘制方法将被用来在画布上渲染该类的自定义视图
@interface UIView (KJXib)

/// 判断一个控件是否真正显示在主窗口
- (BOOL)kj_isShowingOnKeyWindow;

/// xib创建的view
+ (instancetype)kj_viewFromXib;

/// xib创建的view
+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame;

/// 寻找子视图
- (UIView*)kj_FindSubviewRecursively:(BOOL(^)(UIView*subview, BOOL* stop))recurse;

/// 当前的控制器
- (UIViewController*)kj_currentViewController;

/******************  xib中显示的属性 - xib创建的view右上角才有这几个选项 ******************/
// 注意: 加上IBInspectable就可以可视化显示相关的属性
/// 圆角边框
@property (nonatomic,strong)IBInspectable UIColor *borderColor;
@property (nonatomic,assign)IBInspectable CGFloat borderWidth;
@property (nonatomic,assign)IBInspectable CGFloat cornerRadius;

/// 阴影 - View默认颜色ClearColor,阴影不会生效
@property (nonatomic,strong)IBInspectable UIColor *shadowColor;// 阴影颜色
@property (nonatomic,assign)IBInspectable CGFloat shadowRadius;// 阴影的圆角
@property (nonatomic,assign)IBInspectable CGFloat shadowOpacity;// 阴影透明度，默认0
@property (nonatomic,assign)IBInspectable CGSize shadowOffset;// 阴影偏移量

@end

NS_ASSUME_NONNULL_END
