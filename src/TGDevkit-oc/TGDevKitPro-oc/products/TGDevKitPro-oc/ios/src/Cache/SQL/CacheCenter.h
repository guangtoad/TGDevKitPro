//
//  CacheCenter.h
//  smartGLink_cn
//
//  Created by toad on 2021/2/7.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "SQLHelper.h"
#import "SQLMacro.h"
#import "DBConfig.h"

#if UseSQLCipher
#import "FMEncryptHelper.h"
#import "FMEncryptDatabaseQueue.h"
#else
#import <FMDB/FMDB.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/// 缓存中心
@interface CacheCenter : NSObject
#if UseSQLCipher
@property (nonatomic,strong) FMEncryptDatabaseQueue * fmdbQueue;
#else
@property (nonatomic,strong) FMDatabaseQueue * fmdbQueue;
#endif

#pragma mark -  -

/// 获取单例
+ (CacheCenter *) getInstance;

#pragma mark -- 查询

/// 查询数据
/// @param sql sql
/// @param class 返回累
/// @return 返回查询结果
- (NSArray *) select:(nonnull NSString *)sql class:(Class)class;

/// 查询数据
/// @param sql sql
/// @param class 返回累
/// @return 返回查询结果
+ (NSArray *) select:(nonnull NSString *)sql class:(nullable Class)class;

/// 查询
/// @param columns 列如果空或者长度小于1查询所有列
/// @param tableName 表名
/// @param wheres 条件，如果给空的话就是无条件查询
/// @param class 转换类，如果给空的者返回NSDictionary
/// @return 查询结果
+ (nullable NSArray *) select:(nullable NSArray<NSString *> *)columns from:(nonnull NSString *)tableName wheres:(nullable  NSArray<NSString *> *)wheres class:(nullable Class)class;

/// 查询
/// @param columns 列如果空或者长度小于1查询所有列
/// @param tableName 表名
/// @param whereInfo 条件，如果给空的话就是无条件查询默认填充 "=" 其他条件使用其他函数,数字类型默认转换为int
/// @param class 转换类，如果给空的者返回NSDictionary
/// @return 查询结果
+ (nullable NSArray *) select:(nullable NSArray<NSString *> *)columns from:(nonnull NSString *)tableName whereInfo:(nullable NSDictionary<NSString *,NSObject *> *)whereInfo class:(nullable Class)class;

/// 查询
/// @param columns 列如果空或者长度小于1查询所有列
/// @param tableName 表名
/// @param wheres 条件，如果给空的话就是无条件查询
/// @param class 转换类，如果给空的者返回NSDictionary
/// @return 查询结果
- (nullable NSArray *) select:(nullable NSArray<NSString *> *)columns from:(nonnull NSString *)tableName wheres:(nullable  NSArray<NSString *> *)wheres class:(nullable Class)class;

#pragma mark -- 更新

/// 更新
/// @param sql SQL文
/// @return 执行结果
- (BOOL) executeUpdate:(NSString *)sql;

/// 更新
/// @param sql SQL文
/// @return 执行结果
+ (BOOL) executeUpdate:(NSString *)sql;

/// 替换操作
/// @param tableName 表名
/// @param infoDict 内容
/// @code
/// {”columns name”: "value",....}
/// @endcode
/// @return 执行结果
- (BOOL) replace:(nonnull NSString *)tableName info:(nonnull NSDictionary<NSString *,NSObject *> *)infoDict;

/// 更新
- (BOOL) update:(nonnull NSString *)tableName key:(nonnull NSString *)key value:(id)value wheres:(nullable  NSArray<NSString *> *)wheres;
- (BOOL) update:(nonnull NSString *)tableName info:(nonnull NSDictionary<NSString *,NSObject *> *)infoDict wheres:(nullable  NSArray<NSString *> *)wheres;

@end

NS_ASSUME_NONNULL_END
