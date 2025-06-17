//
//  MenuPageViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/5.
//

#import "MenuPageViewController.h"

/// 菜单页视图
@interface MenuPageViewController ()

@end

/// 菜单页视图
@implementation MenuPageViewController

/// 菜单数据
- (NSMutableDictionary *)menuInfo{
    if (!_menuInfo) {
        _menuInfo = [[NSMutableDictionary alloc] init];
    }
    return _menuInfo;
}
/// 菜单组
- (NSArray *) menuGroups{
    NSArray *groups = self.menuInfo[TGKEY_GROUPS];
    if (NULL != groups && [groups isKindOfClass:[NSArray class]]){
        return groups;
    }
    else {
        return @[];
    }
}
/// 获取菜单组
/// - Parameter section: section
- (NSDictionary *) menuGroupWithSection:(NSInteger)section{
    NSArray *groups = [self menuGroups];
    if (section < groups.count) {
        NSDictionary *group = [groups objectAtIndex:section];
        if (NULL != group && [group isKindOfClass:[NSDictionary class]]){
            return group;
        }
    }
    return @{};
}
/// 获取菜单里表
/// - Parameter section: section
- (NSArray *) menusWithSection:(NSInteger)section{
    NSDictionary *group = [self menuGroupWithSection:section];
    NSArray *menus = [group objectForKey:TGKEY_MENUS];
    if (NULL != menus && [menus isKindOfClass:[NSArray class]]){
        return menus;
    }
    return @[];
}
/// 获取菜单信息信息
/// - Parameter indexPath: indexPath
- (NSDictionary *) menuInfoWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;;
    NSInteger row = indexPath.row;
    NSArray *menus = [self menusWithSection:section];
    if (NULL != menus && [menus isKindOfClass:[NSArray class]] && row < menus.count){
        NSObject *menu = [menus objectAtIndex:row];
        if ([menu isKindOfClass:[NSDictionary class]]) {
            return (NSDictionary *)menu;
        }
        else if ([menu isKindOfClass:[NSString class]]) {
            return @{TGKEY_TITLE:menu};
        }
        else if ([menu isKindOfClass:[NSNumber class]]) {
            return @{TGKEY_TITLE:[(NSNumber *)menu stringValue]};
        }
        else {
            return @{TGKEY_TITLE:[NSString stringWithFormat:@"%@",menu]};
        }
    }
    return @{};
}
/// 菜单配置路径
- (NSString *) menuConfigFilePath{
    if (NULL != self.menuFilePath && self.menuFilePath.length > 0){
        return [TGFileUtil resourcePath:self.menuFilePath];
    }
    else {
        return [TGFileUtil resourcePath:NSStringFromClass([self class])];
    }
}
/// 重新加载菜单数据
- (void) reloadMenuData{
    [self.dataSource removeAllObjects];
    NSString *filePath = [self menuConfigFilePath];
    NSDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSMutableDictionary *mdict = [[NSMutableDictionary alloc] init];
//
    NSLog(@"%s",__FUNCTION__);
    NSMutableArray *marray = [[NSMutableArray alloc] init];
    
//    [marray arrayByAddingObjectsFromArray:<#(nonnull NSArray *)#>]
    if (NULL != dict && [dict isKindOfClass:[NSDictionary class]]){
        [self.menuInfo addEntriesFromDictionary:dict];
    }
}
/// 中心加载菜单窗体
- (void) reloadMenuView{
    
}
/// 重新加载数据和视图
- (void) reloadMenuDataAndView{
    [self reloadMenuData];
    [self reloadMenuView];
}
/// 注册按钮视图
- (void) registerMenuItemView{
    
}
/// 视图加载后
- (void) viewDidLoad {
    [super viewDidLoad];
    [self registerMenuItemView];
}
/// 是图显示后
/// - Parameter animated: 动画
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.isDataLoaded){
        [self reloadMenuDataAndView];
        self.isDataLoaded = true;
    }
}

- (NSInteger) dataNumber{
    return [self menuGroups].count;
}
- (NSInteger) dataNumberWithSection:(NSInteger)section{
    return [self menusWithSection:section].count;
}

@end
