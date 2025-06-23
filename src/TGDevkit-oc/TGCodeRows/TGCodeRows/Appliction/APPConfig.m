//
//  APPConfig.m
//  TGCodeRows
//
//  Created by toad on 2022/05/10.
//

#import "APPConfig.h"

NSString *const kIsEdit = @"kIsEdit";
NSString *const kPPRowsCheckFileTypes = @"kPPRowsCheckFileTypes";
NSString *const kPPRowsIgnoreFolders = @"kPPRowsIgnoreFolders";
NSString *const kEditCodes = @"kEditCodes";
NSString *const kReloadSettingNotification = @"kReloadSettingNotification";
NSString *const kThreadCount = @"kThreadCount";

@implementation APPConfig

- (void) setThreadCount:(NSInteger)threadCount{
    _threadCount = MIN(60, MAX(2, threadCount));
}
- (NSMutableArray *)checkFileTypes{
    if (!_checkFileTypes) {
        _checkFileTypes = [[NSMutableArray alloc] init];
    }
    return _checkFileTypes;
}
- (NSMutableArray *)ignoreFolders{
    if (!_ignoreFolders) {
        _ignoreFolders = [[NSMutableArray alloc] init];
    }
    return _ignoreFolders;
}

- (NSMutableArray *)editCodes{
    if (!_editCodes) {
        _editCodes = [[NSMutableArray alloc] init];
    }
    return _editCodes;
}

- (NSArray *)defaultIgnoreFolders{
    NSArray *array = @[@"Pods"];
    return array;
}
- (NSArray *)defaultFileTypes{
    NSArray *array = @[@"h",@"m",@"swift",@"c",@"java",@"mm",@"cpp",@"js",@"py"];
    return array;
}

- (id) init{
    if (self = [super init]) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        // 如果设置未更改
        if (![userDefault boolForKey:kIsEdit]) {
            [userDefault setObject:self.defaultFileTypes forKey:kPPRowsCheckFileTypes];
            [userDefault setObject:self.defaultIgnoreFolders forKey:kPPRowsIgnoreFolders];
            [userDefault setInteger:1 forKey:kThreadCount];
        }
        self.threadCount = [userDefault integerForKey:kThreadCount];
        [self.checkFileTypes addObjectsFromArray:[userDefault objectForKey:kPPRowsCheckFileTypes]];
        [self.ignoreFolders addObjectsFromArray:[userDefault objectForKey:kPPRowsIgnoreFolders]];
        [self.editCodes addObjectsFromArray:[userDefault objectForKey:kEditCodes]];
    }
    return self;
}
/// 获取单例
+ (APPConfig *) getInstance{
    static APPConfig *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (BOOL) save{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    // 如果设置未更改
    [userDefault setBool:YES forKey:kIsEdit];
    [userDefault setObject:self.defaultFileTypes forKey:kPPRowsCheckFileTypes];
    [userDefault setObject:self.defaultIgnoreFolders forKey:kPPRowsIgnoreFolders];
    [userDefault setInteger:self.threadCount forKey:kThreadCount];
    return [userDefault synchronize];
}
@end
