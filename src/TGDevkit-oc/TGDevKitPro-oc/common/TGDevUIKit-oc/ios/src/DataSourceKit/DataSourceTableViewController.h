//
//  DataSourceTableViewController.h
//  TGDevelopToolsApp
//
//  Created by toad on 2024/1/4.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataSourceTableViewController : BaseViewController

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL isDataLoaded;

#pragma mark - MJRefresh
- (void) setupTableViewMJ;
- (void) setupTableViewRefreshingWithHeaderBlock:(MJRefreshComponentAction)headerBlock footerBlock:(MJRefreshComponentAction)footerBlock;
- (void) setupTableViewRefreshingWithTarget:(id)target headerRefreshingAction:(SEL)headerRefreshingAction footerRefreshingAction:(SEL)footerRefreshingAction;
- (void) setupTableViewRefreshing;
- (void) footerRefreshing;
- (void) beginHeaderRefreshing;
- (void) headerRefreshing;
@end

NS_ASSUME_NONNULL_END
