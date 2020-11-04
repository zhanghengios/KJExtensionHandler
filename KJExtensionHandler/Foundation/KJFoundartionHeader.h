//
//  KJFoundartionHeader.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/30.
//  https://github.com/yangKJ/KJExtensionHandler
/*
*********************************************************************************
*
*⭐️⭐️⭐️ ----- 本人其他库 ----- ⭐️⭐️⭐️
*
粒子效果、自定义控件、自定义选中控件
pod 'KJEmitterView'
pod 'KJEmitterView/Control' # 自定义控件
 
扩展库 - Button图文混排、点击事件封装、扩大点击域、点赞粒子效果，
手势封装、圆角渐变、倒影、投影、内阴影、内外发光、渐变色滑块等，
图片压缩加工处理、滤镜渲染、泛洪算法、识别网址超链接等等
pod 'KJExtensionHandler'
pod 'KJExtensionHandler/Foundation'
pod 'KJExtensionHandler/Exception'  # 异常处理

基类库 - 封装整理常用，采用链式处理，提炼独立工具
pod 'KJBaseHandler'
pod 'KJBaseHandler/Tool' # 工具相关
pod 'KJBaseHandler/Router' # 路由相关

播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
pod 'KJPlayer'  # 播放器功能区
pod 'KJPlayer/KJPlayerView'  # 自带展示界面

轮播图 - 支持缩放 多种pagecontrol 支持继承自定义样式 自带网络加载和缓存
pod 'KJBannerView'  # 轮播图，网络图片加载 支持网络GIF和网络图片和本地图片混合轮播

加载Loading - 多种样式供选择 HUD控件封装
pod 'KJLoading' # 加载控件

菜单控件 - 下拉控件 选择控件
pod 'KJMenuView' # 菜单控件

工具库 - 推送工具、网络下载工具、识别网页图片工具等
pod 'KJWorkbox' # 系统工具
pod 'KJWorkbox/CommonBox'
 
Github地址：https://github.com/yangKJ
简书地址：https://www.jianshu.com/u/c84c00476ab6
博客地址：https://blog.csdn.net/qq_34534179
 
* 如果觉得好用,希望您能Star支持,你的 ⭐️ 是我持续更新的动力!
*
*********************************************************************************
*/
#ifndef KJFoundartionHeader_h
#define KJFoundartionHeader_h

#import "NSObject+KJKVO.h"    /// 键值监听封装
#import "NSObject+KJMath.h"   /// 数学方程式
#import "NSObject+KJSignal.h" /// 信号方式解耦工具
#import "NSObject+KJGeometry.h" /// 几何方程式
#import "NSString+KJChinese.h"  /// 汉字相关处理
#import "NSString+KJExtension.h"/// 扩展属性
#import "NSString+KJPredicate.h"/// 谓词工具
#import "NSArray+KJPredicate.h" /// 谓词工具
#import "NSArray+ElementDeal.h" /// 对数组元素的处理 包括排序、查找、去重等等

#endif /* KJFoundartionHeader_h */
