//
//  CacheCenter.h
//  smartGLink_cn
//
//  Created by toad on 2021/2/7.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLDef.h"
#import "TGSQLiteHelper.h"
#import "TGFileUtil.h"

NS_ASSUME_NONNULL_BEGIN

/// 缓存中心
@interface CacheCenter : NSObject

@property (nonatomic,strong) TGSQLiteHelper *sqlliteHelper;

#pragma mark -  -

/// 获取单例
+ (CacheCenter *) getInstance;
+ (NSArray *) getWebHistoryListWith;
+ (BOOL) replaceWebHistoryWithURL:(NSString *)url;
+ (BOOL) deleteWebHistoryWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
