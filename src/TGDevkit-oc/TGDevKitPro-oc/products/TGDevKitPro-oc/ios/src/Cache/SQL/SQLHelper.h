//
//  SQLHelper.h
//  smartGLink_cn
//
//  Created by toad on 2021/2/8.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConfig.h"

NS_ASSUME_NONNULL_BEGIN


@interface SQLHelper : NSObject

/// 查询
/// @param select 查询条件
/// @param from 表明
/// @param where 条件
+ (nullable NSString *) select:(nullable NSString *)select from:(nonnull NSString *)from where:(nullable NSString *)where;

/// 通过GUID查询本地用户数据
/// @param guid GUID
+ (nullable NSString *) selectUserDataByGUID:(NSString *)guid;

+ (nullable NSString *) install:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values;

/// 插入数据
/// @param tableName 表名
/// @param columns 列
/// @param values 值
/// @return 返回查询结果
+ (nullable NSString *) replace:(nonnull NSString *)tableName columns:(nonnull NSString *)columns values:(nonnull NSString *)values;
@end

NS_ASSUME_NONNULL_END
