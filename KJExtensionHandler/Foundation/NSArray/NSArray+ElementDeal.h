//
//  NSArray+ElementDeal.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/8/14.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  对数组里面元素的相关处理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ElementDeal)
/// 随机打乱数组
- (NSArray*)kj_disorganizeArray;
/// 删除数组当中的相同元素
- (NSArray*)kj_delArrayEquelObj;
/// 查找数据，返回-1表示未查询到
- (NSInteger)kj_searchDataWithTarget:(id)target;
/// 生成一组不重复的随机数
- (NSArray*)kj_noRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger)max count:(NSInteger)count;
/// 二分查找，当数据量很大适宜采用该方法
- (NSInteger)kj_binarySearchTarget:(NSInteger)target;
/// 冒泡排序
- (NSArray*)kj_bubbleSort;
/// 插入排序
- (NSArray*)kj_insertSort;
/// 选择排序
- (NSArray*)kj_selectionSort;

@end

NS_ASSUME_NONNULL_END
