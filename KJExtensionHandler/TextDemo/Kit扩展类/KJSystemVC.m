//
//  KJSystemVC.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/11.
//

#import "KJSystemVC.h"
#import "UIDevice+KJSystem.h"
@interface KJSystemVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *temps;

@end

@implementation KJSystemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.temps count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableViewCell"];
    NSDictionary *dic = self.temps[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row + 1,dic[@"Title"]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenW-80, 0, 80, 40)];
//    sw.tag = 520 + indexPath.row;
//    [sw addTarget:self action:@selector(switchAction:) forControlEvents:(UIControlEventValueChanged)];
//    sw.centerY = cell.contentView.height/2;
//    [cell.contentView addSubview:sw];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [UIDevice kj_shareActivityWithItems:@[UIImagePNGRepresentation(kGetImage(@"IMG_4931"))] ViewController:self Complete:^(BOOL success) {
            
        }];
    }else if (indexPath.row == 1) {
//        [UIDevice kj_savedPhotosAlbumWithImage:kGetImage(@"IMG_4931") Complete:^(BOOL success) {
//
//        }];
    }
}
#pragma mark - Actions
- (void)switchAction:(UISwitch*)sender{
    
}
#pragma mark - lazy
- (NSMutableArray *)temps{
    if (!_temps) {
        _temps = [NSMutableArray array];
        [_temps addObject:@{@"Title":@"原生分享"}];
        [_temps addObject:@{@"Title":@"保存到相册"}];
    }
    return _temps;
}

@end
