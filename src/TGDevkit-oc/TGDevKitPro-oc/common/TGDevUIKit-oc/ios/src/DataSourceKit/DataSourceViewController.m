//
//  BaseDataViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import "DataSourceViewController.h"
#import <objc/runtime.h>


@implementation DataSourceViewController

- (void) didDataLoad{
    self.isDataLoaded = true;
}
- (void) reloadData{
    self.pageNumber = 0;
    if (NULL != self.tableView) {
        [self.tableView reloadData];
    }
    [self didDataLoad];
}

#pragma mark - 生命周
/// 视图加载后
- (void) viewDidLoad{
    [super viewDidLoad];
    self.isDataLoaded = false;
    if (NULL != self.tableView) {
        if (NULL == self.tableView.delegate){
            self.tableView.delegate = self;
        }
        if (NULL == self.tableView.dataSource){
            self.tableView.dataSource = self;
        }
    }
}
/// 视图显示后
/// - Parameter animated: 动画标示
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self dataNumberWithSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NULL;
}


#pragma mark - MJRefresh

- (void) setupTableViewMJ{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
}
- (void) setupTableViewRefreshingWithHeaderBlock:(MJRefreshComponentAction)headerBlock footerBlock:(MJRefreshComponentAction)footerBlock{
    if (NULL != headerBlock) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerBlock];
    }
    if (NULL != footerBlock) {
        self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:footerBlock];
    }
}
- (void) setupTableViewRefreshingWithTarget:(id)target headerRefreshingAction:(SEL)headerRefreshingAction footerRefreshingAction:(SEL)footerRefreshingAction{
    if (NULL != headerRefreshingAction){
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerRefreshingAction];
    }
    if (NULL != headerRefreshingAction){
        self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:target refreshingAction:footerRefreshingAction];
    }
}
- (void) setupTableViewRefreshing{
    [self setupTableViewRefreshingWithTarget:self headerRefreshingAction:@selector(headerRefreshing) footerRefreshingAction:@selector(footerRefreshing)];
}
- (void) footerRefreshing{
    [self.tableView.mj_footer endRefreshing];
}
- (void) beginHeaderRefreshing{
    [self.tableView.mj_header beginRefreshing];
}
- (void) headerRefreshing{
    [self.tableView.mj_header endRefreshing];
}
@end

