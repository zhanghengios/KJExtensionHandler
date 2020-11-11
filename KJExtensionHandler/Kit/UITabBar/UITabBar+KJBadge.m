//
//  UITabBar+KJBadge.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/5.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UITabBar+KJBadge.h"
#import <objc/runtime.h>
@implementation UITabBar (KJBadge)
+ (NSInteger)tabBarCount{
    return [objc_getAssociatedObject(self, @selector(tabBarCount)) intValue];
}
+ (void)setTabBarCount:(NSInteger)tabBarCount{
    objc_setAssociatedObject(self, @selector(tabBarCount), @(tabBarCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 当前的TabBar个数
+ (void)kj_tabBarCount:(NSInteger)count{
    self.tabBarCount = count;
}
- (void)kj_showRedBadgeOnItemIndex:(NSInteger)index{
    [self removeRedBadgeOnItemIndex:index];
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 6.5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    float percentX = (index+0.6) / UITabBar.tabBarCount?:4;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 13, 13);
    [self addSubview:badgeView];
}

- (void)kj_hideRedBadgeOnItemIndex:(NSInteger)index{
    [self removeRedBadgeOnItemIndex:index];
}

- (void)removeRedBadgeOnItemIndex:(NSInteger)index{
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
