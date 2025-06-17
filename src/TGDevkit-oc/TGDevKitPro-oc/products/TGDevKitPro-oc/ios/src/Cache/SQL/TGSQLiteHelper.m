//
//  SQLHelper.m
//  smartGLink_cn
//
//  Created by toad on 2021/2/8.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif

#import "TGSQLiteHelper.h"

@implementation TGSQLiteHelper

/// 获取单例
+ (TGSQLiteHelper *) getInstance{
    static TGSQLiteHelper *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)initWithPath:(NSString *)aPath{
    if (self = [self init]){
        self.fmdbQueue = [[FMDatabaseQueue alloc] initWithPath:aPath];
    }
    return self;
}

- (NSInteger) openFlages{

    return [self.fmdbQueue openFlags];
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

#pragma mark - 增加

/// 插入数据
/// @param tableName 表名
/// @param columns 列
/// @param values 值
/// @return 返回查询结果
+ (nullable NSString *) install:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values{
    if (nil == tableName || ![tableName isKindOfClass:[NSString class]] || tableName.length > 0 ) {
        return nil;
    }
    return [NSString stringWithFormat:@"INSERT INTO %@ (%@)  VALUES (%@)",tableName,columns,values];
}
/// 插入数据
/// @param tableName 表名
/// @param columns 列
/// @param values 值
/// @return 返回查询结果
+ (nullable NSString *) replace:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values{
    if (nil == tableName || ![tableName isKindOfClass:[NSString class]] || tableName.length <= 0 ) {
        return nil;
    }
    return [NSString stringWithFormat:@"REPLACE INTO %@ (%@)  VALUES (%@)",tableName,columns,values];
}


#pragma mark - 删除

/// 删除
/// @param tableName: 表名
/// @param whereInfo: 条件
/// @return 执行结果
/// @remark 多个条件使用 <NSString *,NSArray<NSString *> *>
- (BOOL)deleteWithTableName:(NSString *)tableName wheresInfo:(NSDictionary *)whereInfo{
    if (NULL == whereInfo || ![whereInfo isKindOfClass:[NSDictionary  class]] && whereInfo.count < 1){
        return false;
    }
    NSMutableArray *wheres = [[NSMutableArray alloc] init];
    for (NSString *key in [whereInfo allKeys]) {
        NSObject *value = [whereInfo objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            for (NSObject * obj in value) {
                NSString *where = [NSString stringWithFormat:@"%@='%@'",key,obj];
                [wheres addObject:where];
            }
        }
        else {
            NSString *where = [NSString stringWithFormat:@"%@='%@'",key,[whereInfo objectForKey:key]];
            [wheres addObject:where];
        }
    }
    return [self deleteWithTableName:tableName wheres:wheres];
}

- (BOOL)deleteWithTableName:(NSString *)tableName wheres:(NSArray<NSString *> *)wheres{
    if (NULL == wheres || ![wheres isKindOfClass:[NSArray<NSString *>  class]] && wheres.count < 1){
        return false;
    }
    BOOL result = false;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName,[wheres componentsJoinedByString:@" AND "]];
    result = [self executeUpdate:sql];
    return result;
}

#pragma mark - 修改

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

#pragma mark - 查询

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
                        id obj = [class mj_objectWithKeyValues:dict];
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

+ (BOOL) initWithPath:(NSString *)aPath{
    return [[self getInstance] initWithPath:aPath];
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
    return [[self getInstance] select:columns from:tableName wheres:wheres class:class];
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
    return [[self getInstance] select:columns from:tableName whereInfo:whereInfo class:class];
}
#pragma mark - SQL文相关
+ (nullable NSString *) select:(nullable NSString *)select from:(nonnull NSString *)from where:(nullable NSString *)where{
    return [NSString stringWithFormat:@"SELECT %@ FROM %@%@",(nil != select && select.length > 0) ? select:@"*",from,(nil != where && where.length > 0) ? [NSString stringWithFormat:@" WHERE %@",where] : @""];
}


#pragma mark - SQLLite -

/// 更新
/// @param sql SQL文
/// @return 执行结果
+ (BOOL) executeUpdate:(NSString *)sql{
    return [[[self class] getInstance] executeUpdate:sql];
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
        NSString *sql = [TGSQLiteHelper replace:tableName columns:columns values:values];
        result = [self executeUpdate:sql];
    }
    return result;
}
//
- (BOOL)replace:(NSString *)tableName info:(NSDictionary<NSString *,NSObject *> *)infoDict wheres:(NSArray<NSString *> *)wheres {
    BOOL result = false;
    
    if (nil != infoDict && infoDict.count > 0) {
        NSMutableArray *keyArray = [[NSMutableArray alloc] init];
        NSMutableArray *valueArray = [[NSMutableArray alloc] init];
        
        for (NSString *key in [infoDict allKeys]) {
            [keyArray addObject:key];
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
            [valueArray addObject:value];
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
        
        NSString *sql = [NSString stringWithFormat:@"REPLACE INTO %@ (%@) VALUES (%@) @",tableName,[keyArray componentsJoinedByString:@", "],[valueArray componentsJoinedByString:@", "],where];
        result = [self executeUpdate:sql];
    }
    
    return result;
}
// 爱加密复测对应 2022/08/12 lxd
// 爱加密复测 数据库更改列名对应 2022/08/12 STA lxd
/// 修改列名
/// @param tableName 表名
/// @param columns 列
/// @param values 新列名
- (BOOL) alter:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values {
    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME COLUMN %@ TO %@",tableName,columns,values];
    BOOL result = [self executeUpdate:sql];
    return result;
}

// 爱加密复测 数据库更改列名对应 2022/08/12 END lxd
#pragma mark - Realm -

#pragma mark -- DataBase

#pragma mark - Action -

- (id) init{
    if (self = [super init]) {
    }
    return self;
}

@end
