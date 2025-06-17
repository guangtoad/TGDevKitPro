//
//  WebDevelopToolController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import "WebDevelopToolController.h"
#import "WebDebugViewController.h"
#import "CacheCenter.h"

@implementation WebDevelopToolController

- (void) headerRefreshing{
    [self.dataSource removeAllObjects];
    NSArray *history = [CacheCenter getWebHistoryListWith];
    [self.dataSource addObjectsFromArray:history];
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}
- (void) footerRefreshing{
}
- (IBAction) click_openWebDebugController:(id)sender{
    WebDebugViewController *controller = [[WebDebugViewController alloc] initWithNibName:@"WebDebugViewController" bundle:NULL];
    controller.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark - 生命周期

#pragma mark - UIViewController
/// 视图加载后
- (void) viewDidLoad{
    [super viewDidLoad];
    [self setupTableViewRefreshing];
    self.txtUrl.text = @"http://192.168.0.161/js/appjs.html";
}
/// 视图加载后
/// - Parameter animated: 动画
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.isDataLoaded) {
        [self beginHeaderRefreshing];
        self.isDataLoaded = true;
    }
}
/// 准备跳转
/// - Parameters:
///   - segue:
///   - sender: sender description
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender{
    if (NULL == segue.destinationViewController){
        
    }
    else if ([segue.destinationViewController isKindOfClass:[WebDebugViewController class]]){
        WebDebugViewController *controller = segue.destinationViewController;
        controller.urlStr = self.txtUrl.text;
        controller.hidesBottomBarWhenPushed = true;
        
        if ([CacheCenter replaceWebHistoryWithURL:self.txtUrl.text]){
            TGLOGINFO(@"保存成功：%@",self.txtUrl.text);
        }
        else {
            TGLOGERROR(@"保存失败：%@",self.txtUrl.text);
        }
    }
    else if ([segue.destinationViewController isKindOfClass:[WebDevelopToolController class]]){
        
    }
    else {
        
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NULL];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[dict objectForKey:TGKEY_URL]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除的行数：%ld",(long)indexPath.row);
        NSInteger row = indexPath.row;
        NSDictionary *dict = [self.dataSource objectAtIndex:row];
        if ([CacheCenter deleteWebHistoryWithURL:[dict objectForKey:TGKEY_URL]]){
            [self.dataSource removeObjectAtIndex:row];
        }
        else {
            [self showAlert:@"删除失败" handler:NULL];
        }
        [tableView endUpdates];
        [tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//改变左滑后按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.textLabel.text.length > 0){
        [self.txtUrl performSelectorOnMainThread:@selector(setText:) withObject:cell.textLabel.text waitUntilDone:false];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
