//
//  ListMenuController.m
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import "MenuTableViewController.h"
#import "MenuTableCellView.h";

@interface MenuTableViewController () <NSTableViewDelegate,NSTableViewDataSource>

@property (nonatomic,strong) IBInspectable NSString *configPath;

@end

@implementation MenuTableViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSDictionary *) dictFromeDataArrayWithIndex:(NSInteger)index{
    if (index < 0 || index >= self.dataArray.count){
        return NULL;
    }
    id objc = [self.dataArray objectAtIndex:index];
    if ([objc isKindOfClass:[NSString class]]){
        return @{TGKEY_TITLE:objc};
    }
    else if ([objc isKindOfClass:[NSNumber class]]){
        return @{TGKEY_TITLE:[objc stringValue]};
    }
    else if (![objc isKindOfClass:[NSDictionary class]]){
        return @{};
    }
    return objc;
}

- (NSString *) menuConfigFilePath{
    if (NULL != self.configPath && self.configPath.length > 0){
        return [TGFileUtil resourcePath:self.configPath];
    }
    else {
        return [TGFileUtil resourcePath:NSStringFromClass([self class])];
    }
}

- (NSDictionary *) loadMenuData{
    return [[NSDictionary alloc] initWithContentsOfFile:[self menuConfigFilePath]];
}

- (void) setupWithConfigFile{
    NSDictionary *dict = [self loadMenuData];
    NSString *title = [dict objectForKey:TGKEY_TITLE];
    if (NULL != title && [title isKindOfClass:[NSString class]]){
        [self setTitle:title];
    }
    NSArray *array = [dict objectForKey:TGKEY_MENUS];
    if (NULL != array && [array isKindOfClass:[NSArray class]] && array.count > 0){
        [self.dataArray addObjectsFromArray:array];
    }
    [self.menuTableView reloadData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupWithConfigFile];
    
    if (![MenuTableCellView registerToTableView:self.menuTableView]) {
        TGLOGWARRY(@"[MenuTableCellView registerToTableView:self.menuTableView] error");
    };
    
    if (NULL != self.menuTableView) {
        self.menuTableView.delegate = self;
        self.menuTableView.dataSource = self;
    }
}
#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    if ([tableView isEqual:self.menuTableView]) {
        return self.dataArray.count;
    }
    return 0;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    static NSString* const kRowIdentifier = @"MenuTableRowView";
//    NSTableRowView *rowView = [tableView rowViewAtRow:row makeIfNecessary:true];
    NSTableRowView *rowView = [tableView makeViewWithIdentifier:kRowIdentifier owner:self];
    if (!rowView && ![rowView isKindOfClass:[MenuTableRowView class]]) {
        rowView = [[MenuTableRowView alloc] init];
        rowView.identifier = kRowIdentifier;
        NSDictionary *itemDict = NULL;
        if (row < self.dataArray.count){
            id obj = self.dataArray[row];
            if (NULL == obj){
            }
            else if([obj isKindOfClass:[NSString class]]){
                itemDict = @{
                    TGKEY_TITLE:@"",
                    TGKEY_URL:@""
                };
            }
            else if([obj isKindOfClass:[NSDictionary class]]){
                itemDict = obj;
            }
            else {
                
            }
        }
        else {
        }
        [(MenuTableRowView *)rowView reloadDataWithDictionary:itemDict];
    }
    return rowView;
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    MenuTableCellView *view = [tableView makeViewWithIdentifier:[MenuTableCellView viewIdentifier] owner:self];
    NSDictionary *dataDict = [self dictFromeDataArrayWithIndex:row];
    if (NULL == view && [view isKindOfClass:[MenuTableCellView class]]) {
        TGLOGWARRY(@"获取View失败");
    }
    else {
        [view reloadDataWithDict:dataDict];
    }
    return view;
}
- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    return NULL;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    if ([NSTableViewSelectionDidChangeNotification isEqualToString:notification.name]){
        if ([notification.object isEqual:self.menuTableView]){
            NSLog(@"self.menuTableView.selectedRow:%ld",self.menuTableView.selectedRow);
            NSInteger row = self.menuTableView.selectedRow;
            if (NULL != self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(menuTableViewController:didSelectRow:info:)]){
                [self.menuDelegate menuTableViewController:self didSelectRow:row info:[self dictFromeDataArrayWithIndex:row]];
            }
        }
    }
}

@end
