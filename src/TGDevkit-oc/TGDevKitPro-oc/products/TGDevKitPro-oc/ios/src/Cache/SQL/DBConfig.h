//
//  DBConfig.h
//  smartGLink_cn
//
//  Created by toad on 2021/2/8.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * _Nonnull SQLKEY NS_EXTENSIBLE_STRING_ENUM;

#pragma mark - 数据库设置 -

#pragma mark -- 表名

/// 用户表
UIKIT_EXTERN const SQLKEY TBL_CarInfo;
/// 车辆表
UIKIT_EXTERN const SQLKEY TBL_UserInfo;
/// 契约提醒表
UIKIT_EXTERN const SQLKEY TBL_ComExpReminder;
/// 契约提醒历史表
UIKIT_EXTERN const SQLKEY TBL_ComExpReminderHistory;
/// 21MM车辆表
UIKIT_EXTERN const SQLKEY TBL_21MM_CarInfo;

#pragma mark -- 键名


NS_ASSUME_NONNULL_BEGIN

@interface DBConfig : NSObject

@end

NS_ASSUME_NONNULL_END
