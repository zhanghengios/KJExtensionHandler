# KJExtensionHandler
<p align="left">
<img src="https://img.zcool.cn/community/0161da5541af81000001a64bc753a4.jpg@1280w_1l_2o_100sh.jpg" width="666" hspace="1px">
</p>

##### 上传到Cocoapods `pod trunk push KJExtensionHandler.podspec --allow-warnings`

* 这个工程提供开发中用到的类目，方便开发
* 这里有我经常用到的扩展，方便好用开发
* 整理好用的自定义控件，部分数据来源于网络 

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-5cccc7ddb754fef5.gif?imageMogr2/auto-orient/strip" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-ee290038a762cac4.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-eb62f6e462505d69.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-a2dc9062541cf24c.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-eaca7b4e368efb93.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-ec3102711073b390.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-4a4811a1bf4a09d2.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-b5c171bee7c7bae5.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-f75249465cc14d81.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
</p>

----------------------------------------
### 框架整体介绍
* [作者信息](#作者信息)
* [作者其他库](#作者其他库)
* [功能介绍](#功能介绍)
* [Cocoapods安装](#Cocoapods安装)
* [更新日志](#更新日志)
* [效果图](#效果图)
* [目录结构](#目录结构)
* [打赏作者 &radic;](#打赏作者)

----------------------------------------

#### <a id="作者信息"></a>作者信息
> Github地址：https://github.com/yangKJ  
> 简书地址：https://www.jianshu.com/u/c84c00476ab6  
> 博客地址：https://blog.csdn.net/qq_34534179  


#### <a id="作者其他库"></a>作者其他Pod库
```
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
pod 'KJExtensionHandler/Exception' # 异常处理

基类库 - 封装整理常用，采用链式处理，提炼独立工具
pod 'KJBaseHandler'
pod 'KJBaseHandler/Tool' # 工具相关
pod 'KJBaseHandler/Router' # 路由相关

播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
pod 'KJPlayer' # 播放器功能区
pod 'KJPlayer/KJPlayerView' # 自带展示界面

轮播图 - 支持缩放 多种pagecontrol 支持继承自定义样式 自带网络加载和缓存
pod 'KJBannerView'  # 轮播图，网络图片加载 支持网络GIF和网络图片和本地图片混合轮播

加载Loading - 多种样式供选择 HUD控件封装
pod 'KJLoading' # 加载控件

菜单控件 - 下拉控件 选择控件
pod 'KJMenuView' # 菜单控件

工具库 - 推送工具、网络下载工具、识别网页图片工具等
pod 'KJWorkbox' # 系统工具
pod 'KJWorkbox/CommonBox'

* 如果觉得好用,希望您能Star支持,你的 ⭐️ 是我持续更新的动力!
*
*********************************************************************************
*/
```

#### <a id="Cocoapods安装"></a>Cocoapods安装
```
pod 'KJExtensionHandler'
pod 'KJExtensionHandler/Foundation'
pod 'KJExtensionHandler/Exception'
```

#### <a id="更新日志"></a>更新日志
```
####版本更新日志:
#### Add 0.0.7
1. 重写 UIView+KJGestureBlock 解决手势共存问题
2. UIView+KJRectCorner 完善处理
3. 新增 CALayer+KJExtension 增加标签属性

#### Add 0.0.6
1. 新增 UITabBar+KJBadge 小红点处理
2. 新增 _KJGCD 处理线程相关
3. 重写指示器按钮 UIButton+KJIndicator 
4. 重写点赞粒子效果 kj_buttonSetEmitterImage:OpenEmitter:
5. 重写 UINavigationItem+KJExtension 采用链式处理
6. 新增 UITextView+KJBackout 撤销输入
7. UILabel+KJExtension 新增文本显示位置属性 kTextAlignmentType

#### Add 0.0.5
1. UIView+KJXib 新增判断是否有子视图在滚动 anySubViewScrolling
2. UIView+KJFrame 新增移除所有子视图 kj_removeAllSubviews
3. 新增 NSString+KJChinese 汉字相关操作
4. UIView+KJRectCorner 修改局部边框处理
5. UIView+KJXib 新增设置图片属性 viewImage
6. 新增 UIImage+KJGIF 动态图显示gif
7. 新增 UIImage+KJJoint 拼接图片相关操作

#### Add 0.0.4
1. 新增 UIView+Toast 快捷显示
2. 新增 UIResponder+KJChain 响应链处理
3. 新增 NSObject+KJKVO 键值监听简单封装

#### Add 0.0.3
1. 新增 UIResponder+KJAdapt 简单的比例适配
2. 新增 NSArray+KJPredicate 谓词数组处理
3. 新增 NSString+KJPredicate 谓词字符串处理

#### Add 0.0.2
1. 新增Exception异常处理
2. UITextView 增加是否开启方法交换委托处理

#### Add 0.0.1
1. 从原先的KJEmitterView库中分离出来

备注：部分资料来源于网络～ 就不一一指出道谢，整理起来方便自己和大家使用
```
#### <a id="效果图"></a>效果图
<p align="left">
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590984664032&di=f75bbfdf1c76e20749fd40be9c784738&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20181208%2F2e9d5c7277094ace8e7385e018ccc2d4.jpeg" width="666" hspace="1px">
</p>

#### <a id="打赏作者"></a>打赏作者
* 如果你觉得有帮助，还请为我Star
* 如果在使用过程中遇到什么问题，希望你能Issues，我会及时修复
* 大家有什么需要添加的功能，也可以给我留言，有空我将补充完善
* 谢谢大家的支持 - -！

[![谢谢老板](https://upload-images.jianshu.io/upload_images/1933747-879572df848f758a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)](https://github.com/yangKJ/KJPlayerDemo)

#### 救救孩子吧，谢谢各位老板～～～～
