//
//  FMEncryptDatabaseQueue.m
//  smartGLink_cn
//
//  Created by syqb on 2022/5/7.
//  Copyright © 2022 TechnoASKA. All rights reserved.
//

#import "FMEncryptDatabaseQueue.h"
#import "FMEncryptDatabase.h"
#if FMDB_SQLITE_STANDALONE
#import <sqlite3/sqlite3.h>
#else
#import <sqlite3.h>
#endif
static const void * const kDispatchQueueSpecificKey = &kDispatchQueueSpecificKey;
@interface FMEncryptDatabaseQueue (){
    dispatch_queue_t    _queue;
    FMEncryptDatabase   *_db;
    NSString *_encryptKey;
}

@end

@implementation FMEncryptDatabaseQueue
@synthesize path = _path;
@synthesize openFlags = _openFlags;

+ (Class)databaseClass {
    return [FMEncryptDatabase class];
}
- (instancetype)initWithPath:(NSString *)aPath encryptKey:(NSString *)encryptKey {
    return [self initWithPath:aPath flags:SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE vfs:nil encryptKey:encryptKey];
}

- (instancetype)initWithPath:(NSString*)aPath flags:(int)openFlags vfs:(NSString *)vfsName encryptKey:(NSString *)encryptKey {
    self = [super init];
    if (self != nil) {
        _encryptKey = encryptKey;
        _db = [[[self class] databaseClass] databaseWithPath:aPath encryptKey:encryptKey];
        FMDBRetain(_db);
        
#if SQLITE_VERSION_NUMBER >= 3005000
        BOOL success = [_db openWithFlags:openFlags vfs:vfsName];
#else
        BOOL success = [_db open];
#endif
        if (!success) {
            NSLog(@"Could not create database queue for path %@", aPath);
            FMDBRelease(self);
            return 0x00;
        }
        
        _path = FMDBReturnRetained(aPath);
        
        _queue = dispatch_queue_create([[NSString stringWithFormat:@"fmdb.%@", self] UTF8String], NULL);
        dispatch_queue_set_specific(_queue, kDispatchQueueSpecificKey, (__bridge void *)self, NULL);
        _openFlags = openFlags;
    }
    
    return self;
}

#pragma mark - Override Method
- (void)inDatabase:(__attribute__((noescape)) void (^)(FMDatabase *db))block {
#ifndef NDEBUG
    /* Get the currently executing queue (which should probably be nil, but in theory could be another DB queue
     * and then check it against self to make sure we're not about to deadlock. */
    FMDatabaseQueue *currentSyncQueue = (__bridge id)dispatch_get_specific(kDispatchQueueSpecificKey);
    assert(currentSyncQueue != self && "inDatabase: was called reentrantly on the same queue, which would lead to a deadlock");
#endif
    
    FMDBRetain(self);
    
    dispatch_sync(_queue, ^() {
        
        FMDatabase *db = [self database];
        
        block(db);
        
        if ([db hasOpenResultSets]) {
            NSLog(@"Warning: there is at least one open result set around after performing [FMDatabaseQueue inDatabase:]");
            
#if defined(DEBUG) && DEBUG
            NSSet *openSetCopy = FMDBReturnAutoreleased([[db valueForKey:@"_openResultSets"] copy]);
            for (NSValue *rsInWrappedInATastyValueMeal in openSetCopy) {
                FMResultSet *rs = (FMResultSet *)[rsInWrappedInATastyValueMeal pointerValue];
                NSLog(@"query: '%@'", [rs query]);
            }
#endif
        }
    });
    
    FMDBRelease(self);
}

- (FMDatabase*)database {
    if (![_db isOpen]) {
        if (!_db) {
            _db = FMDBReturnRetained([[[self class] databaseClass] databaseWithPath:_path encryptKey:_encryptKey]);
        }
        
#if SQLITE_VERSION_NUMBER >= 3005000
        BOOL success = [_db openWithFlags:_openFlags];
#else
        BOOL success = [_db open];
#endif
        if (!success) {
            NSLog(@"FMDatabaseQueue could not reopen database for path %@", _path);
            FMDBRelease(_db);
            _db  = 0x00;
            return 0x00;
        }
    }
    
    return _db;
}
@end
