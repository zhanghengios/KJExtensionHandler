//
//  _KJMacros.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

#ifndef _KJMacros_h
#define _KJMacros_h

#pragma mark - ////////////////////////////// 宏相关 //////////////////////////////

#pragma mark ********** 1.缩写 ************
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow // KeyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate  // AppDelegate
#define kNotificationCenter [NSNotificationCenter defaultCenter] // 通知中心
#define KPostNotification(name,obj,info) [[NSNotificationCenter defaultCenter]postNotificationName:name object:obj userInfo:info] // 发送通知

#pragma mark ********** 2.自定义高效率的 NSLog ************
#ifdef DEBUG // 输出日志 (格式: [编译时间] [文件名] [方法名] [行号] [输出内容])
#define NSLog(FORMAT, ...) fprintf(stderr,"------- 😎 给我点赞 😎 -------\n编译时间:%s\n文件名:%s\n方法名:%s\n行号:%d\n打印信息:%s\n\n", __TIME__,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__func__,__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

#define kNSSTRING_NOT_NIL(value)  value ? value : @""
#define kNSARRAY_NOT_NIL(value)  value ? value : @[]
#define kNSDICTIONARY_NOT_NIL(value)  value ? value : @{}
#define kNSSTRING_VALUE_OPTIONAL(value)  [value isKindOfClass:[NSString class] ] ? value : nil
#define kINT_TO_STRING(intValue) [NSString stringWithFormat:@"%ld", (long)intValue]
#define kDELEGATE_HAS_METHOD(method) self.delegate&&[self.delegate respondsToSelector:@selector(method)]
#define kDELEGATE_WITH_NAME_HAS_METHOD(delegateName,method) self.delegateName&&[self.delegateName respondsToSelector:@selector(method)]
#define kTN_DEPRECATED(message) __attribute((deprecated(message)))

// 字符串拼接
#define kStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
// block相关宏
#define kBlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil
// 版本判定 大于等于某个版本
#define kSystemVersion(version) ([[[UIDevice currentDevice] systemVersion] compare:@#version options:NSNumericSearch] != NSOrderedAscending)
// 获取时间间隔宏
#define kTimeTick CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kTimeTock NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start);

#pragma mark ********** 3.弱引用 *********
#define _weakself __weak __typeof(&*self) weakself = self
#ifndef kWeakObject
#if DEBUG
#if __has_feature(objc_arc)
#define kWeakObject(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define kWeakObject(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef kStrongObject
#if DEBUG
#if __has_feature(objc_arc)
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#pragma mark ********** 5.iPhoneX系列尺寸布局   *********
// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
// tabBar height
#define kTABBAR_HEIGHT (iPhoneX ? (49.f+34.f):49.f)
// statusBar height
#define kSTATUSBAR_HEIGHT (iPhoneX ? 44.0f : 20.f)
// navigationBar height
#define kNAVIGATION_HEIGHT (44.f)
// (navigationBar + statusBar) height
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX ? 88.0f : 64.f)
// 没有tabar 距 底边高度
#define kBOTTOM_SPACE_HEIGHT (iPhoneX ? 34.0f : 0.0f)
// 屏幕尺寸
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
#define kRect       CGRectMake(0, 0, kScreenW, kScreenH)
// AutoSize
#define kAutoW(r)   (r * kScreenW / 375.0)
#define kAutoH(r)   (r * kScreenH / 667.0)

#define kIphone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenMaxLength (MAX(kScreenW, kScreenH))
#define kScreenMinLength (MIN(kScreenW, kScreenH))
#define kISiPhone5  (kISiPhone && kScreenMaxLength == 568.0)
#define kISiPhone6  (kISiPhone && kScreenMaxLength == 667.0)
#define kISiPhone6P (kISiPhone && kScreenMaxLength == 736.0)
#define kISiPhoneX  (kISiPhone && kScreenMaxLength == 812.0)
#define kISiPhoneXr (kISiPhone && kScreenMaxLength == 896.0)
#define kISiPhoneXX (kISiPhone && kScreenMaxLength >  811.0)

/// 支持横屏可以用下面的宏
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define kLandscapeScreenW    ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define kLandscapeScreenH    ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define kLandscapeScreenSize ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define kLandscapeScreenW    [UIScreen mainScreen].bounds.size.width
#define kLandscapeScreenH    [UIScreen mainScreen].bounds.size.height
#define kLandscapeScreenSize [UIScreen mainScreen].bounds.size
#endif

#pragma mark ********** 6.颜色和图片相关   *********
#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define UIColorHexFromRGB(hex)    UIColorFromHEXA(hex,1.0)
// 设置图片
#define kGetImage(imageName) ([UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]])
// 通过图片获取图片颜色
#define kImageToColor(image) [UIColor colorWithPatternImage:image]

#pragma mark ********** 7.方法  *********
// text size(文字尺寸)
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define kTEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define kTEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif
// 属性快速声明（建议使用代码块）
#define KJ_PROPERTY_STRING(name) @property(nonatomic,copy)NSString *name
#define KJ_PROPERTY_ASSIGN(name) @property(nonatomic,assign)NSInteger name
#define KJ_PROPERTY_STRONG(type,name) @property(nonatomic,strong)type *name
// runtime 为对象类型属性快速生成get/set方法
#define KJ_SYNTHESIZE_CATEGORY_OBJ_PROPERTY(propertyGetter, propertySetter)\
- (id)propertyGetter{ return objc_getAssociatedObject(self, @selector(propertyGetter));}\
- (void)propertySetter(id)obj{ objc_setAssociatedObject(self, @selector(propertyGetter), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
// 为基本数据类型属性快速生成get/set方法
#define KJ_SYNTHESIZE_CATEGORY_VALUE_PROPERTY(valueType, propertyGetter, propertySetter)\
- (valueType)propertyGetter{\
valueType ret = {0};\
[objc_getAssociatedObject(self, @selector(propertyGetter)) getValue:&ret];\
return ret;\
}\
- (void)propertySetter(valueType)value{\
NSValue *valueObj = [NSValue valueWithBytes:&value objCType:@encode(valueType)];\
objc_setAssociatedObject(self, @selector(propertyGetter), valueObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

// 带自动提示的keypath宏(源自Reactive Cocoa) 要添加@符号，就是为了能预编译出TARGET中所有的KEYPATH属性
#define kKeypath2(OBJ, PATH) (((void)(NO && ((void)OBJ.PATH, NO)), #PATH))

/** 单例宏 单例的目的 : 希望对象只创建一个实例，并且提供一个全局的访问点
 使用方法:
 .h文件
 kSingletonImplementation_H(类名)
 
 .m文件
 kSingletonImplementation_M(类名)
 
 调用方法
 类名 *vc = [类名 shared类名];
 */
// 1. 解决.h文件
#define kSingletonImplementation_H(className) \
+ (instancetype)shared##className;

// 2. 解决.m文件
// 判断 是否是 ARC
#if __has_feature(objc_arc)
#define kSingletonImplementation_M(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
}
#else
// MRC 部分
#define kSingletonImplementation_M(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}
#endif // 提示，最后一行不要使用

#pragma mark ********** 8.系统默认字体设置和自选字体设置    *********
#define kSystemFontSize(fontsize)  [UIFont systemFontOfSize:(fontsize)]
#define kSystemBlodFontSize(fontsize)   [UIFont boldSystemFontOfSize:(fontsize)] /// 粗体
#define kSystemItalicFontSize(fontsize) [UIFont italicSystemFontOfSize:(fontsize)]

#pragma mark ********** 9.NSUserDefaults相关    *********
#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 永久存储对象
#define kSetUserDefaults(object, key) ({ \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];  \
[defaults setObject:object forKey:key];   \
[defaults synchronize]; })
// 获取对象
#define kGetUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
// 删除某一个对象
#define kRemoveUserDefaults(key) ({ \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; \
[defaults removeObjectForKey:key]; \
[defaults synchronize]; })
// 清除 NSUserDefaults 保存的所有数据
#define kRemoveAllUserDefaults  [kUserDefaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]

#pragma mark ********** 10.获取时间    *********
//获得当前的年份
#define kCurrentYear  [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]
//获得当前的月份
#define kCurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
//获得当前的日期
#define kCurrentDay   [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
//获得当前的小时
#define kCurrentHour  [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
//获得当前的分
#define kCurrentMin   [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
//获得当前的秒
#define kCurrentSec   [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]

#pragma mark ********** 11.线程 GCD   *********
/* 使用方式  kGCD_MAIN_ASYNC(^{ NSLog(@"77"); }); */
//GCD - 异步主线程
#define kGCD_MAIN_ASYNC(main_queue_block) dispatch_async(dispatch_get_main_queue(), main_queue_block)
//GCD - 异步子线程
#define kGCD_QUEUE_ASYNC(global_queue_block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), global_queue_block)
//GCD - 一次性执行
#define kGCD_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 异步并行队列
#define kGCD_GROUP_ASYNC(group_async_block,group_notify_block) \
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);\
dispatch_group_t group = dispatch_group_create();\
dispatch_group_async(group, queue, group_async_block);\
dispatch_group_notify(group, queue, ^{\
dispatch_async(dispatch_get_main_queue(), group_notify_block);\
})\

#endif /* _KJMacros_h */
