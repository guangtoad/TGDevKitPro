//
//  BaseDataViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import "DataSourceViewController.h"
#import <objc/runtime.h>

NSString const *TGUIKey_DataSource = @"TGUIKey_DataSource";
NSString const *TGUIKey_IsDataLoaded = @"TGUIKey_IsDataLoaded";

@implementation UIViewController (DataSource)

- (void)setIsDataLoaded:(BOOL)isDataLoaded{
    objc_setAssociatedObject(self, &TGUIKey_IsDataLoaded, @(isDataLoaded), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isDataLoaded{
    return [objc_getAssociatedObject(self, &TGUIKey_IsDataLoaded) boolValue];
}
- (void)setDataSource:(NSMutableArray *)dataSource{
    objc_setAssociatedObject(self, &TGUIKey_DataSource, dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)dataSource{
    NSMutableArray * array = objc_getAssociatedObject(self, &TGUIKey_DataSource);
    if (NULL == array) {
        array = [[NSMutableArray alloc] init];
        [self setDataSource:array];
    }
    return array;
}

#pragma mark - Data Source
- (NSInteger ) dataNumber{
    return self.dataSource.count;
}
- (NSInteger ) dataNumberWithSection:(NSInteger)section{
    if (section < self.dataSource.count) {
        NSObject *object = [self.dataSource objectAtIndex:section];
        if (NULL == object) {
            return 0;
        }
        else if ([object isKindOfClass:[NSArray class]]) {
            return [(NSArray *)object count];
        }
        else {
            return 1;
        }
    }
    return 0;
}
- (NSArray *) objectsFormeDataSoureWithSection:(NSInteger)section{
    if (section < self.dataSource.count) {
        NSObject *obj = [self.dataSource objectAtIndex:section];
        if (NULL == obj) {
            return NULL;
        }
        else if ([obj isKindOfClass:[NSArray class]]) {
            return (NSArray *)obj;
        }
        else {
            return @[obj];
        }
    }
    else {
        return NULL;
    }
    return NULL;
}
- (NSObject *) objectFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSArray *objects = [self objectsFormeDataSoureWithSection:section];
    if (NULL == objects) {
        return NULL;
    }
    NSInteger row = indexPath.row;
    if (row < objects.count) {
        [objects objectAtIndex:row];
    }
    return NULL;
}
- (NSObject *) dictionaryFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath{
    NSObject *object = [self objectFormeDataSoureWithIndexPath:indexPath];
    if (NULL != object) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            return object;
        }
        else if ([object isKindOfClass:[NSString class]]){
            return @{TGKEY_TITLE:object};
        }
        else {
            return @{TGKEY_INFO:object};
        }
    }
    return NULL;
}

@end

@implementation DataSourceViewController

- (void) didDataLoad{
    self.isDataLoaded = true;
}
- (void) reloadData{
    self.pageNumber = 0;
    if (NULL != self.tableView) {
        [self.tableView reloadData];
    }
    [self didDataLoad];
}

#pragma mark - 生命周
/// 视图加载后
- (void) viewDidLoad{
    [super viewDidLoad];
    self.isDataLoaded = false;
    if (NULL != self.tableView) {
        if (NULL == self.tableView.delegate){
            self.tableView.delegate = self;
        }
        if (NULL == self.tableView.dataSource){
            self.tableView.dataSource = self;
        }
    }
}
/// 视图显示后
/// - Parameter animated: 动画标示
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self dataNumberWithSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NULL;
}

@end

