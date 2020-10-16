//
//  ViewController.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/9/25.
//

#import "ViewController.h"
#import "KJHomeView.h"
#import "KJHomeModel.h"
#import "KJExceptionTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
    
    KJHomeModel *model = [KJHomeModel new];
    KJHomeView *view = [[KJHomeView alloc]initWithFrame:self.view.bounds];
    view.sectionTemps = model.sectionTemps;
    view.temps = model.temps;
    [self.view addSubview:view];
    
    _weakself;
    [NSObject kj_receivedSignalWithSender:view SignalBlock:^id _Nullable(NSString * _Nonnull key, id  _Nonnull message, id  _Nonnull parameter) {
        if ([key isEqualToString:kHomeViewKey]) {
            ((UIViewController*)message).title = ((NSDictionary*)parameter)[@"describeName"];
            [weakself.navigationController pushViewController:message animated:true];
        }
        return nil;
    }];
}

- (void)test{
    [KJExceptionTool kj_openAllExchangeMethod];
    [KJExceptionTool kj_crashBlock:^BOOL(NSDictionary * _Nonnull dict) {
        NSLog(@"回调处理:\n%@", dict[@"crashTitle"]);
        return YES;
    }];
    NSMutableArray *temp = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    NSString *str = nil;
    [temp addObject:str];
    [temp setObject:@"1" atIndexedSubscript:4];
    [temp insertObject:str atIndex:4];
    NSDictionary *dicX = @{str:@"123",
                           @"key":str,
                           @"key":@"1"
    };
    NSLog(@"%@",dicX);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjects:@[@"1",@"1"] forKeys:@[@"2",@"2"]];
    [dict setObject:str forKey:@"3"];
    [dict removeObjectForKey:str];
}

@end
