//
//  FMEncryptDatabase.m
//  smartGLink_cn
//
//  Created by syqb on 2022/5/7.
//  Copyright © 2022 TechnoASKA. All rights reserved.
//

#import "FMEncryptDatabase.h"
#if FMDB_SQLITE_STANDALONE
#import <sqlite3/sqlite3.h>
#else
#import <sqlite3.h>
#endif
@interface FMEncryptDatabase ()
{
    NSString *_encryptKey;
}

@end
@implementation FMEncryptDatabase

+ (instancetype)databaseWithPath:(NSString*)aPath encryptKey:(NSString *)encryptKey
{
    return FMDBReturnAutoreleased([[self alloc] initWithPath:aPath encryptKey:encryptKey]);
}

- (instancetype)initWithPath:(NSString*)aPath encryptKey:(NSString *)encryptKey
{
    if (self = [self initWithPath:aPath]) {
        _encryptKey = encryptKey;
    }
    return self;
}

#pragma mark - Override Method
- (BOOL)open
{
    BOOL res = [super open];
    if (res && _encryptKey) {
        //数据库open后设置加密key
        [self setKey:_encryptKey];
    }
    return res;
}

- (BOOL)openWithFlags:(int)flags vfs:(NSString *)vfsName {
#if SQLITE_VERSION_NUMBER >= 3005000
    BOOL res = [super openWithFlags:flags vfs:vfsName];
    if (res && _encryptKey) {
        //数据库open后设置加密key
        [self setKey:_encryptKey];
    }
    return res;
#else
    NSLog(@"openWithFlags requires SQLite 3.5");
    return NO;
#endif
}
@end
