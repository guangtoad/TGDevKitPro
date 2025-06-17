//
//  BaseDataViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import <UIKit/UIKit.h>
#import "TGDevelopToolsUIKit.h"

NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (DataSource)

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) BOOL isDataLoaded;

#pragma mark - Data Source
- (NSInteger ) dataNumber;
- (NSInteger ) dataNumberWithSection:(NSInteger)section;
- (NSArray *) objectsFormeDataSoureWithSection:(NSInteger)section;
- (NSObject *) objectFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath;
- (NSObject *) dictionaryFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface DataSourceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,assign) NSInteger pageNumberSize;
@property (nonatomic,assign) NSInteger pageNumber;

- (void) reloadData;

@end

NS_ASSUME_NONNULL_END
