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

#import "SQLHelper.h"



@implementation SQLHelper

+ (nullable NSString *) select:(nullable NSString *)select from:(nonnull NSString *)from where:(nullable NSString *)where{
    return [NSString stringWithFormat:@"SELECT %@ FROM %@%@",(nil != select && select.length > 0) ? select:@"*",from,(nil != where && where.length > 0) ? [NSString stringWithFormat:@" WHERE %@",where] : @""];
}

+ (nullable NSString *) selectUserDataByGUID:(NSString *)guid{
    return [self select:nil from:TBL_ComExpReminder where:@""];
}

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

@end
