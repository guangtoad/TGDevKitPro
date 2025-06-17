//
//  BaseTableViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "DataSourceTableViewController.h"
#import <MJRefresh.h>
@interface DataSourceTableViewController ()

@end

@implementation DataSourceTableViewController

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

