//
//  BaseTableViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import <UIKit/UIKit.h>
#import "DataSourceViewController.h"
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataSourceTableViewController : DataSourceViewController<UITableViewDelegate,UITableViewDataSource>

#pragma mark - MJRefresh
- (void) setupTableViewRefreshingWithHeaderBlock:(MJRefreshComponentAction)headerBlock footerBlock:(MJRefreshComponentAction)footerBlock;
- (void) setupTableViewRefreshingWithTarget:(id)target headerRefreshingAction:(SEL)headerRefreshingAction footerRefreshingAction:(SEL)footerRefreshingAction;
- (void) setupTableViewRefreshing;
- (void) beginHeaderRefreshing;

@end

NS_ASSUME_NONNULL_END
