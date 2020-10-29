//
//  NSObject+KJKVO.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/29.
//  键值监听封装

/*  简单使用：
 [self.label kj_observeKey:@"text" ObserveResultBlock:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
     NSLog(@"%@",newData);
 }];
*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol KJNSObjectKVOExchangeMethodProtocol <NSObject>
@required
+ (void)kj_openKVOExchangeMethod;
@end
typedef void(^kObserveResultBlock) (id newData, id oldData,id owner);
@interface NSObject (KJKVO)
/// 记录已经添加监听的keyPath与对应的block
@property(strong,nonatomic,readonly)NSMutableDictionary *kObserveDictionary;
/// kvo监听
- (void)kj_observeKey:(NSString*)key ObserveResultBlock:(kObserveResultBlock)block;

@end

NS_ASSUME_NONNULL_END
