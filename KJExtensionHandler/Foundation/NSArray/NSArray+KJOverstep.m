//
//  NSArray+Overstep.m
//  MoLiao
//
//  Created by 杨科军 on 2018/8/28.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "NSArray+KJOverstep.h"
#import "NSObject+KJSwizzling.h"

@implementation NSArray (KJOverstep)

+ (void)load {
    static dispatch_once_t onceToken;
    //调用原方法以及新方法进行交换，处理崩溃问题。
    dispatch_once(&onceToken, ^{
        //越界崩溃方式一：[array objectAtIndex:0];
        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndex:)
                                withSwizzledSelector:@selector(safeObjectAtIndex:)];
        
        //越界崩溃方式二：arr[0];   Subscript n:下标、脚注
        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndexedSubscript:)
                                withSwizzledSelector:@selector(safeObjectAtIndexedSubscript:)];
    });
}
- (instancetype)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        /*   __FUNCTION__    输出当前方法   */
        NSLog(@"😓😓😓😓😓😓 数组个数为零 😓😓😓😓😓😓");
        return nil;
    }else if (index < self.count) {
        return [self safeObjectAtIndex:index];
    }
    NSLog(@"😓😓😓😓😓😓 数组索引越界 😓😓😓😓😓😓");
    return nil; // 越界返回为nil
}

- (instancetype)safeObjectAtIndexedSubscript:(NSUInteger)index{
    if (self.count == 0) {
        NSLog(@"😓😓😓😓😓😓 数组个数为零 😓😓😓😓😓😓");
        return nil;
    }else if (index < self.count) {
        return [self safeObjectAtIndexedSubscript:index];
    }
    NSLog(@"😓😓😓😓😓😓 数组索引越界 😓😓😓😓😓😓");
    return nil; // 越界返回为nil
}
@end


@implementation NSMutableArray (Overstep)

+ (void)load {
    // 调用原方法以及新方法进行交换，处理崩溃问题
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1、提示移除的数据不能为空
        [self swizzleSelector:@selector(removeObject:)
         withSwizzledSelector:@selector(kj_removeObject:)];
        //2、提示数组不能添加为nil的数据
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:)
                                withSwizzledSelector:@selector(kj_addObject:)];
        //3、移除数据越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:)
                                withSwizzledSelector:@selector(kj_removeObjectAtIndex:)];
        //4、插入数据越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:)
                                withSwizzledSelector:@selector(kj_insertObject:atIndex:)];
        //5、处理[arr objectAtIndex:0]这样的越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:)
                                withSwizzledSelector:@selector(kj_objectAtIndex:)];
        //6、处理arr[0]这样的越界
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndexedSubscript:)
                                withSwizzledSelector:@selector(kj_objectAtIndexedSubscript:)];
        //7、添加数据中有nil的情况，剔除掉nil
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:)
                                          withSwizzledSelector:@selector(kj_initWithObjects:count:)];
    });
}

#pragma mark - 交换的方法
- (void)kj_removeObject:(id)obj {
    if (obj == nil) {
        NSLog(@"😓😓😓😓😓😓 提示移除的数据不能为空 😓😓😓😓😓😓");
        return;
    }
    [self kj_removeObject:obj];
}

- (void)kj_addObject:(id)obj {
    if (obj == nil) {
        NSLog(@"😓😓😓😓😓😓 提示数组不能添加为nil的数据 😓😓😓😓😓😓");
    } else {
        [self kj_addObject:obj];
    }
}

- (void)kj_removeObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"😓😓😓😓😓😓 数组个数为空 😓😓😓😓😓😓");
    }else if (index < self.count) {
        [self kj_removeObjectAtIndex:index];
    }else{
        NSLog(@"😓😓😓😓😓😓 数组移出索引越界 😓😓😓😓😓😓");
    }
}

- (void)kj_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"😓😓😓😓😓😓 空数据不能插入数组 😓😓😓😓😓😓");
    } else if (index > self.count) {
        NSLog(@"😓😓😓😓😓😓 数组插入索引越界 😓😓😓😓😓😓");
    } else {
        [self kj_insertObject:anObject atIndex:index];
    }
}

- (instancetype)kj_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"😓😓😓😓😓😓 数组个数为零 😓😓😓😓😓😓");
        return nil;
    }else if (index < self.count) {
        // 这时候调用自己，看起来像是死循环
        // 但是其实自己的实现已经被替换了
        return [self kj_objectAtIndex:index];
    }
    NSLog(@"😓😓😓😓😓😓 数组索引越界 😓😓😓😓😓😓");
    return nil; // 越界返回为nil
}

- (instancetype)kj_objectAtIndexedSubscript:(NSUInteger)index{
    if (self.count == 0) {
        NSLog(@"😓😓😓😓😓😓 数组个数为零 😓😓😓😓😓😓");
        return nil;
    }else if (index < self.count) {
        // 这时候调用自己，看起来像是死循环
        // 但是其实自己的实现已经被替换了
        return [self kj_objectAtIndexedSubscript:index];
    }
    NSLog(@"😓😓😓😓😓😓 数组索引越界 😓😓😓😓😓😓");
    return nil; // 越界返回为nil
}

- (instancetype)kj_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    for (NSInteger i = 0; i < cnt; i++) {
//        if ([objects[i] isKindOfClass:[NSArray class]]) {
//            NSLog(@"%@", objects[i]);
//        }
        if (objects[i] == nil) {
            hasNilObject = YES;
//            NSLog(@"%s 添加数据中 %ld 为 nil, 剔除掉 nil", __FUNCTION__, i);
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
//        NSLog(@"%@", [NSThread callStackSymbols]);
        return [self kj_initWithObjects:newObjects count:index];
    }
    return [self kj_initWithObjects:objects count:cnt];
}

@end


