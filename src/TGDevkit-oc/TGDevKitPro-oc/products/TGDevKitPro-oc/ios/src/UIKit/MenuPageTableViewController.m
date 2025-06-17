//
//  MenuListViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//
// 列表菜单视图

#import "MenuPageTableViewController.h"

/// 列表菜单视图
@interface MenuPageTableViewController ()

@end

/// 列表菜单视图
@implementation MenuPageTableViewController

/// 注册按钮视图
- (void) registerMenuItemView{
    if (NULL != self.tableView) {
        UINib *nib = [UINib nibWithNibName:@"MenuPageTableViewCell" bundle:NULL];
        [self.tableView registerNib:nib forCellReuseIdentifier:[MenuPageTableViewCell itemIdentifier]];
        
    }
}
- (NSString *) loadMenuWithPath:(NSString *)path{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:path];
    NSDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    return @"";
}
- (void) loadMenu{
    [self loadMenuWithPath:[self menuFilePath]];
}
- (void) reloadMenuView{
    [self.tableView reloadData];
}
- (void) viewDidLoad{
    [super viewDidLoad];
    if (NULL != self.tableView) {
        if (NULL == self.tableView.delegate) {
            self.tableView.delegate = self;
        }
        if (NULL == self.tableView.dataSource) {
            self.tableView.dataSource = self;
        }
    }
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat result = 64;
    return result;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger result = [self dataNumber];
    return result;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger result = [self dataNumberWithSection:section];
    return result;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuPageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (NULL == cell && ![cell isKindOfClass:[MenuPageTableViewCell class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:[MenuPageTableViewCell itemIdentifier]];
        if (NULL == cell && ![cell isKindOfClass:[MenuPageTableViewCell class]]) {
            cell = [[MenuPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MenuPageTableViewCell itemIdentifier]];
        }
    }
    NSDictionary *menuInfo = [self menuInfoWithIndexPath:indexPath];
    [cell reloadWithInfo:menuInfo];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *group = [self menuGroupWithSection:section];
    NSString *title = [group objectForKey:TGKEY_TITLE];
    if (NULL != title) {
        return title;
    }
    return @"";
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (NULL != cell) {
        NSString *roulerURL = cell.tg_RoulerURL;
        if (![self tg_oepnRUI:roulerURL]){
            
        }
        else {
            
        }
        [cell setSelected:false];
    }
    else {
        
    }
}

@end
