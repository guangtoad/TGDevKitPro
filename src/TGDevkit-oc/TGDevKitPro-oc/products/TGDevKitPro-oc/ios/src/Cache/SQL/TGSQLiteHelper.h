//
//  SQLHelper.h
//  smartGLink_cn
//
//  Created by toad on 2021/2/8.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "TGSQLiteHelperDef.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGSQLiteHelper : NSObject

@property (nonatomic,strong) FMDatabaseQueue * fmdbQueue;

- (instancetype)initWithPath:(NSString *)aPath;
+ (BOOL) initWithPath:(NSString *)filePath;

/// 获取单例
+ (TGSQLiteHelper *) getInstance;


#pragma mark - 增加

+ (nullable NSString *) install:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values;

/// 插入数据
/// @param tableName 表名
/// @param columns 列
/// @param values 值
/// @return 返回查询结果
+ (nullable NSString *) replace:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values;

/// 替换操作
/// @param tableName 表名
/// @param infoDict 内容
/// @code
/// {”columns name”: "value",....}
/// @endcode
/// @return 执行结果
- (BOOL) replace:(nonnull NSString *)tableName info:(nonnull NSDictionary<NSString *,NSObject *> *)infoDict;

- (BOOL)replace:(NSString *)tableName info:(NSDictionary<NSString *,NSObject *> *)infoDict wheres:(NSArray<NSString *> *)wheres;
#pragma mark - 删除
/// 删除
/// @param tableName: 表名
/// @param whereInfo: 条件
/// @return 执行结果
/// @remark 多个条件使用 <NSString *,NSArray<NSString *> *>
- (BOOL)deleteWithTableName:(NSString *)tableName wheresInfo:(NSDictionary *)whereInfo;
- (BOOL)deleteWithTableName:(NSString *)tableName wheres:(NSArray<NSString *> *)wheres;

#pragma mark - 修改

/// 更新
/// @param sql SQL文
/// @return 执行结果
- (BOOL) executeUpdate:(NSString *)sql;

/// 更新
/// @param sql SQL文
/// @return 执行结果
+ (BOOL) executeUpdate:(NSString *)sql;

/// 更新
- (BOOL) update:(nonnull NSString *)tableName key:(nonnull NSString *)key value:(id)value wheres:(nullable  NSArray<NSString *> *)wheres;

- (BOOL) update:(nonnull NSString *)tableName info:(nonnull NSDictionary<NSString *,NSObject *> *)infoDict wheres:(nullable  NSArray<NSString *> *)wheres;

#pragma mark - 查询

/// 查询
/// @param select 查询条件
/// @param from 表明
/// @param where 条件
+ (nullable NSString *) select:(nullable NSString *)select from:(nonnull NSString *)from where:(nullable NSString *)where;

/// 通过GUID查询本地用户数据
/// @param guid GUID
+ (nullable NSString *) selectUserDataByGUID:(NSString *)guid;


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
// 爱加密复测对应 2022/08/12  lxd
// 爱加密复测 数据库更改列名对应 2022/08/12 STA lxd
/// 修改列名
/// @param tableName 表名
/// @param columns 列
/// @param values 新列名
- (BOOL) alter:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values;

@end

NS_ASSUME_NONNULL_END
