//
//  CacheCenter.m
//  smartGLink_cn
//
//  Created by toad on 2021/2/7.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//


#import "CacheCenter.h"

/// 缓存中心
@implementation CacheCenter

- (instancetype)init{
    if (self = [super init]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cacheDirectoryPath = [TGFileUtil documentPathWithFilePath:@"cache"];

        {
            BOOL isDirectory = false;
            NSError *error = NULL;
            BOOL isExists = [fileManager fileExistsAtPath:cacheDirectoryPath isDirectory:&isDirectory];
            if (isExists && !isDirectory) {
                TGLOGINFO(@"验证缓存文件夹通过：【%@】",cacheDirectoryPath);
            }
            else {
                if ([fileManager createDirectoryAtPath:cacheDirectoryPath withIntermediateDirectories:true attributes:@{} error:&error]){
                    TGLOGINFO(@"创建缓存文件夹成功：【%@】",cacheDirectoryPath);
                }
                else{
                    TGLOGERROR(@"创建缓存文件夹失败：【%@】",error);
                }
            }
        }
        {
            NSString *dbPath = [TGFileUtil documentPathWithFilePath:@"cache/TGDB.db"];
            BOOL isDirectory = false;
            BOOL isExists = [fileManager fileExistsAtPath:dbPath isDirectory:&isDirectory];
            if (isExists && !isDirectory) {
                TGLOGINFO(@"验证DB文件通过：【%@】",dbPath);
            }
            else {
                NSString *resDB = [TGFileUtil resourcePath:@"DataBase/TGDB.db"];
                TGLOGINFO(@"拷贝DB文件：【%@】to 【%@】",resDB,dbPath);
                NSError *error = NULL;
                if ([fileManager copyItemAtPath:resDB toPath:dbPath error:&error]){
                    TGLOGINFO(@"拷贝DB成功");
                }
                else {
                    TGLOGERROR(@"拷贝DB失败：%@",error);
                };
            }
            self.sqlliteHelper = [[TGSQLiteHelper alloc] init];
            if ([self.sqlliteHelper initWithPath:dbPath]) {
                TGLOGINFO(@"初始化DB成功");
            }
            else {
                TGLOGERROR(@"初始化DB失败");
            };
        }
    }
    return self;
}

/// 获取单例
+ (CacheCenter *) getInstance{
    static CacheCenter *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (NSArray *) getWebHistoryListWith{
    return [[self getInstance].sqlliteHelper select:NULL from:SQLLITE_TBLENAME_WebKitHistory wheres:NULL class:NULL];
}
+ (BOOL) replaceWebHistoryWithURL:(NSString *)url{
    return [[self getInstance].sqlliteHelper  replace:SQLLITE_TBLENAME_WebKitHistory info:@{@"url":url}];
}
+ (BOOL) deleteWebHistoryWithURL:(NSString *)url{
    if (NULL == url) {
        return false;
    }
    return [[self getInstance].sqlliteHelper deleteWithTableName:SQLLITE_TBLENAME_WebKitHistory wheresInfo:@{@"url":url}];
}

@end

