//
//  ListMenuController.h
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import <Cocoa/Cocoa.h>
#import "MenuTableRowView.h"
IB_DESIGNABLE

NS_ASSUME_NONNULL_BEGIN

@class MenuTableViewController;

@protocol MenuTableViewDelegate <NSObject>

@optional
- (BOOL) menuTableViewController:(MenuTableViewController *)controller didSelectRow:(NSInteger)row info:(NSDictionary *)info;

@end

@interface MenuTableViewController : NSViewController

@property (nullable, weak) IBOutlet id <MenuTableViewDelegate> menuDelegate;
@property (nonatomic,weak) IBOutlet NSTableView *menuTableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
