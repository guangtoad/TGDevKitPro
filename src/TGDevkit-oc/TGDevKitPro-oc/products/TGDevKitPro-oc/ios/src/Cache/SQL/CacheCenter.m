//
//  CacheCenter.m
//  smartGLink_cn
//
//  Created by toad on 2021/2/7.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif

#import "CacheCenter.h"
// EDITAJM090 BEGIN
// 爱加密 数据库对应 2022/05/18 START Toad
// 数据库加密
#if UseSQLCipher
#import "FMEncryptHelper.h"
#import "FMEncryptDatabase.h"
#import "FMEncryptDatabaseQueue.h"
#endif
// 爱加密 数据库对应 2022/05/18 END Toad
// EDITAJM090 END
/// 缓存中心
@implementation CacheCenter

/// 获取单例
+ (CacheCenter *) getInstance{
    static CacheCenter *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


#pragma mark - SQLLite -

#pragma mark -- DataBase

/// 数据库文件名称
+ (NSString *) ffdbName{
    return @"elc";
}

/// 数据库文件名称
+ (NSString *) ffdbExtension{
    return @"db";
}

/// 数据库时间
+ (NSString *) ffmdbPath{
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                        NSUserDomainMask, YES);
    NSString *caches = [dirs objectAtIndex:0];
    
    NSString *path = [NSString pathWithComponents:@[caches,[[self class] ffdbName]]];
    path = [path stringByAppendingPathExtension:[[self class] ffdbExtension]];
    return path;
}
// EDITAJM090 BEGIN
// 爱加密 数据库对应 2022/05/18 START Toad
// 数据库加密

/// 加密数据库文件名称
+ (NSString *) effdbName{
    return @"elc_e";
}

/// 加密数据库路径
+ (NSString *) effmdbEntPath{
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                        NSUserDomainMask, YES);
    NSString *caches = [dirs objectAtIndex:0];
    
    NSString *path = [NSString pathWithComponents:@[caches,[[self class] effdbName]]];
    path = [path stringByAppendingPathExtension:[[self class] ffdbExtension]];
    return path;
}
// 爱加密 数据库对应 2022/05/18 END Toad
// EDITAJM090 END
/// 拷贝数据库
- (void) copyDB{
    NSString *dbPath = [[self class] ffmdbPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm isExecutableFileAtPath:dbPath]) {
        NSString *baseDAPath = [[NSBundle mainBundle] pathForResource:[[self class] ffdbName] ofType:[[self class] ffdbExtension]];
        NSError *error = NULL;
        if ([fm copyItemAtPath:baseDAPath toPath:dbPath error:&error] && !error) {
            
        }
        else {
            NSLog(@"Error:%@",error);
        }
    }
}

/// 更新
/// @param sql SQL文
/// @return 执行结果
- (BOOL) executeUpdate:(NSString *)sql{
    __block NSInteger result = false;
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    return result;
}

/// 更新
/// @param sql SQL文
/// @return 执行结果
+ (BOOL) executeUpdate:(NSString *)sql{
    return [[[self class] getInstance] executeUpdate:sql];
}

/// 查询数据
/// @param sql sql
/// @param class 返回累
/// @return 返回查询结果
- (NSArray *) select:(nonnull NSString *)sql class:(Class)class{
    NSMutableArray *arr = NULL;
    @try {
        arr = [[NSMutableArray alloc] init];
        [self.fmdbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *result = [db executeQuery:sql];
            if (NULL != result && result.columnCount > 0) {
                while([result next]) {
                    NSDictionary *dict = [result resultDictionary];
                    if (NULL != class && NULL != dict) {
                        id obj = [class yy_modelWithDictionary:dict];
                        if (obj) {
                            [arr addObject:obj];
                        }
                    }
                    else {
                        if (NULL != dict) {
                            [arr addObject:dict];
                        }
                    }
                }
            }
            [result close];
        }];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return arr;
    
}

/// 查询数据
/// @param sql sql
/// @param class 返回累
/// @return 返回查询结果
+ (NSArray *) select:(nonnull NSString *)sql class:(nullable Class)class{
    return [[[self class] getInstance] select:sql class:class];
    
}

/// 查询
/// @param columns 列如果空或者长度小于1查询所有列
/// @param tableName 表名
/// @param wheres 条件，如果给空的话就是无条件查询
/// @param class 转换类，如果给空的者返回NSDictionary
/// @return 查询结果
- (nullable NSArray *) select:(nullable NSArray<NSString *> *)columns from:(nonnull NSString *)tableName wheres:(nullable  NSArray<NSString *> *)wheres class:(nullable Class)class{
    NSString *column = NULL;
    if (nil == tableName || ![tableName isKindOfClass:[NSString class]] || tableName.length < 1) {
        return NULL;
    }
    if (nil != columns && [columns isKindOfClass:[NSArray class]] && [columns count] > 0) {
        column = [columns componentsJoinedByString:@" , "];
    }
    else {
        column = @"*";
    }
    NSMutableString *where = [[NSMutableString alloc] initWithFormat:@""];
    if (nil != wheres && [wheres isKindOfClass:[NSArray<NSString *> class]]) {
        if (wheres.count < 1) {
            return NULL;
        }
        else {
            [where appendString:@" WHERE "];
            [where appendString:[wheres componentsJoinedByString:@" AND "]];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@%@",column,tableName,where];
    return [self select:sql class:class];
}

/// 查询
/// @param columns 列如果空或者长度小于1查询所有列
/// @param tableName 表名
/// @param wheres 条件，如果给空的话就是无条件查询
/// @param class 转换类，如果给空的者返回NSDictionary
/// @return 查询结果
+ (nullable NSArray *) select:(nullable NSArray<NSString *> *)columns from:(nonnull NSString *)tableName wheres:(nullable  NSArray<NSString *> *)wheres class:(nullable Class)class{
    return [[CacheCenter getInstance] select:columns from:tableName wheres:wheres class:class];
}

/// 查询
/// @param columns 列如果空或者长度小于1查询所有列
/// @param tableName 表名
/// @param whereInfo 条件，如果给空的话就是无条件查询
/// @param class 转换类，如果给空的者返回NSDictionary
/// @return 查询结果
- (nullable NSArray *) select:(nullable NSArray<NSString *> *)columns from:(nonnull NSString *)tableName whereInfo:(nullable NSDictionary<NSString *,NSObject *> *)whereInfo class:(nullable Class)class{
    NSMutableArray *wheres = NULL;
    if (NULL != whereInfo && whereInfo.count > 0) {
        wheres = [[NSMutableArray alloc] init];
        for (NSString *key in [whereInfo allKeys]) {
            NSObject *obj = whereInfo[key];
            if ([obj isKindOfClass:[NSString class]]) {
                [wheres addObject:[NSString stringWithFormat:@"%@ = '%@'",key,obj]];
            }
            else if ([obj isKindOfClass:[NSNumber class]]) {
                [wheres addObject:[NSString stringWithFormat:@"%@ = %ld",key,[(NSNumber *)obj integerValue]]];
            }
            else {
                NSLog(@"未知类型(%@):(%@)",key,obj);
                [wheres addObject:[NSString stringWithFormat:@"%@ = '%@'",key,obj]];
            }
        }
    }
    return [self select:columns from:tableName wheres:wheres class:class];
}

/// 查询
/// @param columns 列如果空或者长度小于1查询所有列
/// @param tableName 表名
/// @param whereInfo 条件，如果给空的话就是无条件查询
/// @param class 转换类，如果给空的者返回NSDictionary
/// @return 查询结果
+ (nullable NSArray *) select:(nullable NSArray<NSString *> *)columns from:(nonnull NSString *)tableName whereInfo:(nullable NSDictionary<NSString *,NSObject *> *)whereInfo class:(nullable Class)class{
    return [[CacheCenter getInstance] select:columns from:tableName whereInfo:whereInfo class:class];
}

/// 替换操作
/// @param tableName 表名
/// @param infoDict 内容
/// @code
/// {”columns name”: "value",....}
/// @endcode
/// @return 执行结果
- (BOOL) replace:(nonnull NSString *)tableName info:(nonnull NSDictionary<NSString *,NSObject *> *)infoDict{
    BOOL result = false;
    if (nil != infoDict && infoDict.count > 0) {
        NSString *columns = [[NSString alloc] init];
        NSString *values = [[NSString alloc] init];
        
        for (NSString *key in infoDict) {
            NSObject *obj = [infoDict objectForKey:key];
            NSString *value = NULL;
            if ([obj isKindOfClass:[NSString class]]) {
                value = [NSString stringWithFormat:@"'%@'",obj];
            }
            else if ([obj isKindOfClass:[NSNumber class]]) {
                value = [NSString stringWithFormat:@"%ld",[(NSNumber *)obj integerValue]];
            }
            else if ([obj isKindOfClass:[NSDate class]]) {
                value = [NSString stringWithFormat:@"'%@'",obj];
            }
            else {
                value = [NSString stringWithFormat:@"'%@'",obj];
            }
            
            if (columns.length > 0) {
                columns = [columns stringByAppendingFormat:@","];
                values = [values stringByAppendingString:@","];
            }
            columns = [columns stringByAppendingString:key];
            values = [values stringByAppendingString:value];
        }
        NSString *sql = [SQLHelper replace:tableName columns:columns values:values];
        result = [self executeUpdate:sql];
    }
    return result;
}

- (BOOL)update:(NSString *)tableName key:(NSString *)key value:(id)value wheres:(NSArray<NSString *> *)wheres {
    BOOL result = false;
    NSMutableString *where = [[NSMutableString alloc] initWithFormat:@""];
    if (nil != wheres && [wheres isKindOfClass:[NSArray<NSString *> class]]) {
        if (wheres.count < 1) {
            return NULL;
        }
        else {
            [where appendString:@" WHERE "];
            [where appendString:[wheres componentsJoinedByString:@" AND "]];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@'%@", tableName, key, value, where];
    result = [self executeUpdate:sql];
    return result;
}

- (BOOL)update:(NSString *)tableName info:(NSDictionary<NSString *,NSObject *> *)infoDict wheres:(NSArray<NSString *> *)wheres {
    BOOL result = false;
    
    if (nil != infoDict && infoDict.count > 0) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (NSString *key in infoDict) {
            NSObject *obj = [infoDict objectForKey:key];
            NSString *value = NULL;
            if ([obj isKindOfClass:[NSString class]]) {
                value = [NSString stringWithFormat:@"'%@'",obj];
            }
            else if ([obj isKindOfClass:[NSNumber class]]) {
                value = [NSString stringWithFormat:@"%ld",[(NSNumber *)obj integerValue]];
            }
            else if ([obj isKindOfClass:[NSDate class]]) {
                value = [NSString stringWithFormat:@"'%@'",obj];
            }
            else {
                value = [NSString stringWithFormat:@"'%@'",obj];
            }
            
            NSString *columnsAndValues = [NSString stringWithFormat:@"%@ = %@", key, value];
            [tempArr addObject:columnsAndValues];
        }
        
        
        
        NSMutableString *where = [[NSMutableString alloc] initWithFormat:@""];
        if (nil != wheres && [wheres isKindOfClass:[NSArray<NSString *> class]]) {
            if (wheres.count < 1) {
                return NULL;
            }
            else {
                [where appendString:@" WHERE "];
                [where appendString:[wheres componentsJoinedByString:@" AND "]];
            }
        }
        
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@%@", tableName, [tempArr componentsJoinedByString:@", "], where];
        result = [self executeUpdate:sql];
    }
    
    return result;
}

#pragma mark - Realm -

#pragma mark -- DataBase

#pragma mark - Action -

- (id) init{
    if (self = [super init]) {
#if UseSQLCipher
        // EDITAJM090 BEGIN
        // 爱加密 数据库对应 2022/05/18 START Toad
        // 数据库加密
        NSString *dbPath = [[self class] ffmdbPath];
        NSString *e_dbPath = [[self class] effmdbEntPath];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:dbPath]) {
            NSError *error = NULL;
            BOOL result = [FMEncryptHelper encryptDatabase:dbPath targetPath:e_dbPath encryptKey:[[self class] encryptKey]];
            if ([fm removeItemAtPath:dbPath error:&error] && !error) {
                
            }
            else {
                // Do nothing
            }
            if (result) {
                
            }
            else if ([fm fileExistsAtPath:e_dbPath]) {
                if ([fm removeItemAtPath:e_dbPath error:&error] && !error) {
                    
                }
                else {
                    // Do nothing
                }
            }
        }
        if (![fm fileExistsAtPath:e_dbPath]) {
            NSString *baseDAPath = [[NSBundle mainBundle] pathForResource:[[self class] effdbName] ofType:[[self class] ffdbExtension]];
            NSLog(@"拷贝数据库");
            NSError *error = NULL;
            if ([fm copyItemAtPath:baseDAPath toPath:e_dbPath error:&error] && !error) {
                
            }
            else {
                NSLog(@"Error:%@",error);
            }
        }
        self.fmdbQueue = [[FMEncryptDatabaseQueue alloc] initWithPath:e_dbPath encryptKey:[[self class] encryptKey]];
        // 爱加密 数据库对应 2022/05/18 END Toad
        // EDITAJM090 END
#else
        NSString *dbPath = [[self class] ffmdbPath];
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:dbPath]) {
            NSString *baseDAPath = [[NSBundle mainBundle] pathForResource:[[self class] ffdbName] ofType:[[self class] ffdbExtension]];
            NSLog(@"拷贝数据库");
            NSError *error = NULL;
            if ([fm copyItemAtPath:baseDAPath toPath:dbPath error:&error] && !error) {
                
            }
            else {
                NSLog(@"Error:%@",error);
            }
        }
        
        self.fmdbQueue = [[FMDatabaseQueue alloc] initWithPath:dbPath];
#endif
    }
    return self;
}
// EDITAJM090 BEGIN
// 爱加密 数据库对应 2022/05/18 START Toad
// 数据库加密
+ (NSString *) encryptKey{
    return ELC_DB_ENCRYPTKEY;
}
+ (NSString *) createTableSQL{
    return SQL_CREATE_tbl_21MM_CarInfo;
}
// 爱加密 数据库对应 2022/05/18 END Toad
// EDITAJM090 END

@end

