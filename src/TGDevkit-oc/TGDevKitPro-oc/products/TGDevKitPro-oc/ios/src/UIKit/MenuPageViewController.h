//
//  MenuPageViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/5.
//

#import "DataSourceViewController.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
/// 菜单页视图
@interface MenuPageViewController : DataSourceViewController
@property (nonatomic,copy) IBInspectable NSString *menuFilePath;
@property (nonatomic,strong) NSMutableDictionary *menuInfo;

/// 重新加载菜单数据
- (void) reloadMenuData;
/// 中心加载菜单窗体
- (void) reloadMenuView;
/// 重新加载数据和视图
- (void) reloadMenuDataAndView;

- (NSArray *) menuGroups;
- (NSInteger) dataNumber;
- (NSDictionary *) menuGroupWithSection:(NSInteger)section;
- (NSArray *) menusWithSection:(NSInteger)section;
- (NSDictionary *) menuInfoWithIndexPath:(NSIndexPath *)indexPath;
- (NSInteger) dataNumberWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
