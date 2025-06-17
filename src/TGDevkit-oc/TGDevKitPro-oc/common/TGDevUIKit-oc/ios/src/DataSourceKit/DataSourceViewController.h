//
//  BaseDataViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import "TGKitPrefix.h"
#import "UIViewController+TG.h"
#import "BaseViewController.h"
//#import "TGDevelopToolsUIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataSourceViewController : BaseViewController< UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,assign) NSInteger pageNumberSize;
@property (nonatomic,assign) NSInteger pageNumber;

- (void) reloadData;
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

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

