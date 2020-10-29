//
//  NSArray+ElementDeal.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/8/14.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSArray+ElementDeal.h"

@implementation NSArray (ElementDeal)
/// 随机打乱数组
- (NSArray*)kj_disorganizeArray{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        return arc4random_uniform(2) ? [obj1 compare:obj2] : [obj2 compare:obj1];
    }];
}
// 删除数组当中的相同元素
- (NSArray*)kj_delArrayEquelObj{
    return [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
}
// 查找数据 返回-1表示未查询到
- (NSInteger)kj_searchDataWithTarget:(id)target{
    NSArray *source = self.mutableCopy;
    unsigned index = (unsigned)CFArrayBSearchValues((CFArrayRef)source, CFRangeMake(0, CFArrayGetCount((CFArrayRef)source)), (CFStringRef)target, (CFComparatorFunction)CFStringCompare, NULL);
    if (index < [source count] && [target isEqualToString:source[index]]){
        return index;
    }else {
        return -1;
    }
}
/// 生成一组不重复的随机数
- (NSArray*)kj_noRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger)max count:(NSInteger)count{
    NSMutableSet *set = [NSMutableSet setWithCapacity:count];
    while (set.count < count) {
        NSInteger value = arc4random() % (max-min+1) + min;
        [set addObject:[NSNumber numberWithInteger:value]];
    }
    return set.allObjects;
}
//MARK: - ---  二分查找
/* 当数据量很大适宜采用该方法 采用二分法查找时，数据需是排好序的
 基本思想：假设数据是按升序排序的，对于给定值x，从序列的中间位置开始比较，如果当前位置值等于x，则查找成功
 若x小于当前位置值，则在数列的前半段 中查找；若x大于当前位置值则在数列的后半段中继续查找，直到找到为止
 */
- (NSInteger)kj_binarySearchTarget:(NSInteger)target{
    if (self == nil) return -1;
    NSInteger start = 0;
    NSInteger end = self.count - 1;
    NSInteger mind = 0;
    while (start < end - 1){
        mind = start + (end - start)/2;
        if ([self[mind] integerValue] > target){
            end = mind;
        }else{
            start = mind;
        }
    }
    if ([self[start] integerValue] == target){
        return start;
    }
    if ([self[end] integerValue] == target){
        return end;
    }
    return -1;
}
//MARK: - --- 冒泡排序
/*
 1. 首先将所有待排序的数字放入工作列表中
 2. 从列表的第一个数字到倒数第二个数字，逐个检查：若某一位上的数字大于他的下一位，则将它与它的下一位交换
 3. 重复2号步骤(倒数的数字加1。例如：第一次到倒数第二个数字，第二次到倒数第三个数字，依此类推...)，直至再也不能交换
 */
- (NSArray *)kj_bubbleSort{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self];
    id temp;
    int i, j;
    NSInteger count = [arr count];
    for (i=0; i < count - 1; ++i){
        for (j=0; j < count - i - 1; ++j){
            if (arr[j] > arr[j+1]){
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
    return arr;
}

//MARK: - --- 插入排序
/*
 1. 从第一个元素开始，认为该元素已经是排好序的
 2. 取下一个元素，在已经排好序的元素序列中从后向前扫描
 3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置
 4. 重复步骤3，直到已排好序的元素小于或等于新元素
 5. 在当前位置插入新元素
 6. 重复步骤2
 */
- (NSArray *)kj_insertSort{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self];
    id temp;
    int i, j;
    NSInteger count = [arr count];
    for (i=1; i < count; ++i){
        temp = arr[i];
        for (j=i; j > 0 && temp < arr[j-1]; --j){
            arr[j] = arr[j-1];
        }
        arr[j] = temp;
    }
    return arr;
}

//MARK: - ---  选择排序
/*
 1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束
 2. i=1
 3. 从数组的第i个元素开始到第n个元素，逐一比较寻找最小的元素
 4. 将上一步找到的最小元素和第i位元素交换
 5. 如果i=n－1算法结束，否则回到第3步
 */
- (NSArray *)kj_selectionSort{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self];
    id temp;
    int min, i, j;
    NSInteger count = [arr count];
    for (i=0; i < count; ++i){
        min = i;
        for (j = i+1; j < count; ++j){
            if (arr[min] > arr[j]) min = j;
        }
        if (min != i){
            temp = arr[min];
            arr[min] = arr[i];
            arr[i] = temp;
        }
    }
    return arr;
}


@end
