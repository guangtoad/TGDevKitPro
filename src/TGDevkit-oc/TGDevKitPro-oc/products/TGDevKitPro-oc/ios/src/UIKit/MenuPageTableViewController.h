//
//  MenuListViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//
// 列表菜单视图

#import <UIKit/UIKit.h>
#import "MenuPageViewController.h"
#import "MenuPageTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

/// 列表菜单视图
@interface MenuPageTableViewController : MenuPageViewController

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
