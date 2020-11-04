//
//  UIView+KJXib.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE // 动态刷新 在类名前加上此宏定义，初始化布置和绘制方法将被用来在画布上渲染该类的自定义视图
@interface UIView (KJXib)

/// Xib创建的View
+ (instancetype)kj_viewFromXib;
/// Xib创建的View
+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame;

/// 当前的控制器
- (UIViewController*)kj_currentViewController;
@property(nonatomic,strong,readonly)UIViewController *viewController;
@property(nonatomic,strong,readonly)UIViewController *topViewController;

/// 判断一个控件是否真正显示在主窗口
- (BOOL)kj_isShowingOnKeyWindow;
@property(nonatomic,assign,readonly) BOOL showKeyWindow;
/// 判断是否有子视图在滚动
- (BOOL)kj_anySubViewScrolling;
@property(nonatomic,assign,readonly) BOOL anySubViewScrolling;


//*********  Xib中显示属性 IBInspectable就可以可视化显示相关的属性  ***********
/// 图片属性，备注这个会覆盖掉UIImageView上面设置的image
@property(nonatomic,strong)IBInspectable UIImage *viewImage;

/// 圆角边框
@property(nonatomic,strong)IBInspectable UIColor *borderColor;
@property(nonatomic,assign)IBInspectable CGFloat borderWidth;
@property(nonatomic,assign)IBInspectable CGFloat cornerRadius;

/// 阴影，备注View默认颜色ClearColor时阴影不会生效
@property(nonatomic,strong)IBInspectable UIColor *shadowColor;// 阴影颜色
@property(nonatomic,assign)IBInspectable CGFloat shadowRadius;// 阴影的圆角
@property(nonatomic,assign)IBInspectable CGFloat shadowOpacity;// 阴影透明度，默认0
@property(nonatomic,assign)IBInspectable CGSize shadowOffset;// 阴影偏移量

@end

NS_ASSUME_NONNULL_END
