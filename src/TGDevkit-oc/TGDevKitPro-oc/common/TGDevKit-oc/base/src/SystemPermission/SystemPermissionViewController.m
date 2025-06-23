//
//  SystemPermissionViewController.m
//  smartGLink_cn
//
//  Created by toad on 2022/01/13.
//
//  系统列表说明页面

#import "SystemPermissionViewController.h"
#import "ELCSystemPermissionViewModel.h"
#import "SystemPermissionDetailViewController.h"

/// 系统列表说明页面
@interface SystemPermissionViewController ()<UITableViewDelegate,UITableViewDataSource>

/// 表
@property (nonatomic,strong) UITableView *taleView;
/// 数据源
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) ELCSystemPermissionViewModel *permissionVM;

@end

/// 系统列表说明页面
@implementation SystemPermissionViewController

#pragma mark - 懒加载

/// 数据源
- (NSMutableArray *) dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithArray:@[
            @{@"TITLE":@"abc",
              @"MESSAGE":@"asdas",
              @"PERMISSION_KEY":@"asdad"
            }
        ]];
    }
    return _dataArray;
}

- (NSString *) getSettingsURLStringWithPermissionKey:(NSString *)perminssionKey{
    return UIApplicationOpenSettingsURLString;
}

- (NSURL *) getSettingsURLWithPermissionKey:(NSString *)permissionKey{
    NSString *URLString = [self getSettingsURLStringWithPermissionKey:permissionKey];
    NSURL *url = NULL;
    if (NULL != URLString && [URLString isKindOfClass:[NSString class]] && URLString.length > 0) {
        url = [[NSURL alloc] initWithString:URLString];
    }
    return url;
}

- (void) openSystemPermissionWithKey:(NSString *)permissionKey{
    NSURL *url = [self getSettingsURLWithPermissionKey:permissionKey];
    [[UIApplication sharedApplication] openURL:url
                                       options:@{
        
    }
                             completionHandler:nil];
}

#pragma mark - LifeCycle

/// 视图加载后
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 视图显示前
/// @param animated 动画
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/// 视图显示后
/// @param animated 动画
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDataSource

/// 生成单元格
/// @param tableView 表
/// @param indexPath 位置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYSTEMPRERMISSIONCELL"];
    }
    NSInteger row = indexPath.row;
    if (row >=0 && row < self.dataArray.count) {
        NSDictionary *dict = self.dataArray[row];
        if (dict != NULL && [dict isKindOfClass:[NSDictionary class]]) {
            
        }
    }
    return cell;
}

/// 显示几组
/// @param tableView 表
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (NULL != self.dataArray) {
        return 1;
    }
    else {
        return 0;
    }
}

/// 显示几个
/// @param tableView 表
/// @param section 第几组
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (NULL != self.dataArray) {
        return self.dataArray.count;
    }
    else {
        return 0;
    }
}

#pragma mark - UITableDelegate

/// 点击了
/// @param tableView 表
/// @param indexPath 位置
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (NULL != cell) {
        [self openSystemPermissionWithKey:cell.reuseIdentifier];
        
    }
}

@end
