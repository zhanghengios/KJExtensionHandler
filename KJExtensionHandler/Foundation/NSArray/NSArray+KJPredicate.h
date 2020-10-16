//
//  NSArray+KJPredicate.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/16.
//  谓词工具

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
// bindings参数:替换变量字典，字典必须包含接收器中所有变量的键值对
typedef BOOL (^kPredicateBlock)(id evaluatedObject,NSDictionary<NSString*,id> *bindings);
@interface NSArray (KJPredicate)
/// 映射
- (NSArray*)kj_mapWithBlock:(id(^)(id object))block;
/// 筛选数据
- (id)kj_detectWithBlock:(BOOL(^)(id object))block;
/// 对比两个数组删除相同元素并合并
- (NSArray*)kj_mergeArrayAndDelEqualObjWithOtherArray:(NSArray*)temp;
/// 过滤数组
- (NSArray*)kj_filtrationDatasWithPredicateBlock:(kPredicateBlock)block;
/// 除去数组当中包含目标数组的数据
- (NSArray*)kj_delEqualDatasWithTargetTemps:(NSArray*)temp;
/// 按照某一属性的升序降序排列
- (NSArray*)kj_sortDescriptorWithKey:(NSString*)key Ascending:(BOOL)ascending;
/// 按照某些属性的升序降序排列
- (NSArray*)kj_sortDescriptorWithKeys:(NSArray*)keys Ascendings:(NSArray*)ascendings;
/// 取出 key 中匹配 value 的元素
- (NSArray*)kj_takeOutDatasWithKey:(NSString*)key Value:(NSString*)value;
/// 字符串比较运算符 beginswith(以*开头)、endswith(以*结尾)、contains(包含)、like(匹配)、matches(正则)，[c]不区分大小写 [d]不区分发音符号即没有重音符号 [cd] 既又
- (NSArray*)kj_takeOutDatasWithOperator:(NSString*)ope Key:(NSString*)key Value:(NSString*)value;

@end

NS_ASSUME_NONNULL_END
