//
//  TGLoggerStorageManager.m
//  TGLog
//
//  Created by toad on 2021/08/30.
//

#import "TGLoggerStorageManager.h"

/// 容器管理
@interface TGLoggerStorageManager()

/// 时间格式化
@property (nonatomic,strong) NSDateFormatter *formater;

/// 控制台
@property (nonatomic,strong) TGLoggerStoreConsole *storeConsole;
/// 本地文件
@property (nonatomic,strong) TGLoggerStoreLocalFile *storeLocalFile;
/// 数据库
@property (nonatomic,strong) TGLoggerStoreSqllite *storeSqllite;

@end

/// 管理
@implementation TGLoggerStorageManager

#pragma mark - 懒加载

/// 控制台
- (TGLoggerStoreConsole *) storeConsole{
    if (!_storeConsole) {
        @synchronized (self) {
            if (!_storeConsole) {
                _storeConsole = [[TGLoggerStoreConsole alloc] initWithTag:self.tag level:self.writeLevel];
            }
        }
    }
    return _storeConsole;
}

/// 本地文件
- (TGLoggerStoreLocalFile *)storeLocalFile{
    if (!_storeLocalFile) {
        @synchronized (self) {
            if (!_storeLocalFile) {
                _storeLocalFile = [[TGLoggerStoreLocalFile alloc] initWithTag:self.tag level:self.writeLevel];
            }
        }
    }
    return _storeLocalFile;
}

/// 数据库
- (TGLoggerStoreSqllite *)storeSqllite{
    if (!_storeSqllite) {
        @synchronized (self) {
            if (!_storeSqllite) {
                _storeSqllite = [[TGLoggerStoreSqllite alloc] initWithTag:self.tag level:self.writeLevel];
            }
        }
    }
    return _storeSqllite;
}

#pragma mark - 初始化

/// 初始化
/// @param tag 标签
/// @param level 级别
/// @param storageType 容器类型
- (instancetype)initWithTag:(NSString *)tag level:(TGLogLevel)level storageType:(TGLoggerStorageType)storageType{
    self = [super initWithTag:tag level:level];
    if (self) {
        _storageType = storageType;
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
        _formater = formater;
    }
    return self;
}

#pragma mark - 配置

/// 设置
/// @param tag 标签
/// @param level 级别
/// @param storageType 容器类型
- (void) setTag:(NSString *)tag level:(TGLogLevel)level storageType:(NSUInteger)storageType{
    
}

/// 设置
/// @param writeLevel 级别
/// @param storageType 容器类型
- (void) setWriteLevel:(TGLogLevel)writeLevel storageType:(NSInteger)storageType{
    
    if ((self.storageType & TGLoggerStorageTypeConsle) == TGLoggerStorageTypeConsle) {
        [self.storeConsole setWriteLevel:writeLevel];
    }
    
    if ((self.storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
        [self.storeLocalFile setWriteLevel:writeLevel];
    }
    
    if ((self.storageType & TGLoggerStorageTypeSqllite) == TGLoggerStorageTypeSqllite) {
        [self.storeSqllite setWriteLevel:writeLevel];
    }
    
    [super setWriteLevel:MIN(MIN(self.storeConsole.writeLevel, self.storeSqllite.writeLevel), self.storeLocalFile.writeLevel)];
}

/// 获取配置
- (__kindof NSDictionary *)getSetting{
    NSDictionary *dict = [super getSetting];
    if (![dict isKindOfClass:[NSMutableDictionary class]]) {
        dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    }
    if ((self.storageType & TGLoggerStorageTypeConsle) == TGLoggerStorageTypeConsle) {
        [dict setValuesForKeysWithDictionary:[self.storeConsole getSetting]];
    }
    if ((self.storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
        [dict setValuesForKeysWithDictionary:[self.storeLocalFile getSetting]];
    }
    if ((self.storageType & TGLoggerStorageTypeSqllite) == TGLoggerStorageTypeSqllite) {
        [dict setValuesForKeysWithDictionary:[self.storeSqllite getSetting]];
    }
    return dict;
}

#pragma mark - 写入

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param storageType 容器类型
/// @param message 内容
- (void) writeTag:(NSString * _Nullable)tag level:(TGLogLevel)level date:(NSDate * _Nullable)date storageType:(NSUInteger)storageType message:(NSString * _Nullable)message{
    if (level >= self.writeLevel && message) {
        NSString *logStr = [self formaterWithTag:tag level:level date:date message:message];
        
        if ((storageType & TGLoggerStorageTypeConsle) == TGLoggerStorageTypeConsle) {
            [self.storeConsole writeLogTag:tag level:level message:logStr];
        }
        
        if ((storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
            [self.storeLocalFile writeLogTag:tag level:level message:logStr];
        }
        
        if ((storageType & TGLoggerStorageTypeSqllite) == TGLoggerStorageTypeSqllite) {
            [self.storeSqllite writeLogTag:tag level:level message:logStr];
        }
    }
}

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param message 内容
- (void) writeTag:(NSString * _Nullable)tag level:(TGLogLevel)level date:(NSDate * _Nullable)date message:(NSString * _Nullable)message {
    [self writeTag:tag level:level date:date storageType:self.storageType message:message];
}

#pragma mark - 读取

/// 读取日志内容
/// @param tag 标签
/// @param level 级别
/// @param path 路径
/// @param storageType 容器类型
- (NSString *) readLogWithTag:(NSString *)tag level:(TGLogLevel)level path:(NSString *)path storageType:(NSUInteger)storageType{
    NSString *result = @"";
    if ((storageType & TGLoggerStorageTypeConsle) == TGLoggerStorageTypeConsle) {
        return @"Console not supported";
    }
    
    if ((storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
        return [self.storeLocalFile readLogWithTag:tag level:level path:path];
    }
    
    if ((storageType & TGLoggerStorageTypeSqllite) == TGLoggerStorageTypeSqllite) {
        return [self.storeSqllite readLogWithTag:tag level:level path:path];
    }
    return result;
}

/// 读取日志内容
/// @param tag 标签
/// @param level 级别
/// @param path 路径
- (NSString *) readLogWithTag:(NSString *)tag level:(TGLogLevel)level path:(NSString *)path{
    if ((self.storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
        return [self readLogWithTag:tag level:level path:path storageType:TGLoggerStorageTypeLocalFile];
    }
    else {
        return @"The file has been closed";
    }
}

#pragma mark - 清理

/// 请求日志
/// @param storageType 容器类型
/// @param date 时间
- (BOOL) clearAllWith:(TGLoggerStorageType)storageType beforeDate:(NSDate *)date{
    if ((storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
        [self.storeLocalFile clearBeforeDate:date];
    }
    if ((storageType & TGLoggerStorageTypeSqllite) == TGLoggerStorageTypeSqllite) {
        [self.storeSqllite clearBeforeDate:date];
    }
    return true;
}

/// 清空日志
/// @param date 时间
/// @param storageType 容器类型
- (BOOL) clearBeforeDate:(NSDate *)date storageType:(TGLoggerStorageType)storageType{
    if ((storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
        [self.storeLocalFile clearBeforeDate:date];
    }
    if ((storageType & TGLoggerStorageTypeSqllite) == TGLoggerStorageTypeSqllite) {
        [self.storeSqllite clearBeforeDate:date];
    }
    return true;
}

/// 清空所有日志
- (BOOL) clearAll{
    return [self clearAllWith:self.storageType beforeDate:[NSDate date]];
}

#pragma mark -

- (void) warlog{
    
}

/// 格式化日志内容
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param message 内容
- (NSString *) formaterWithTag:(NSString * _Nullable)tag level:(TGLogLevel)level date:(NSDate * _Nullable)date message:(NSString * _Nullable)message {
    NSString *result = NULL;
    if (message) {
        
        NSString *threadName = [NSString stringWithUTF8String:dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)];
        NSString *time = [self.formater stringFromDate:NULL != date ? date : [NSDate date]];
        NSString *prefix = TGLogLevelPrefixs[level];
 
        if (threadName && threadName.length > 0) {
            result = [[NSString alloc] initWithFormat:@"%@ [%@] [%@] [%@] %@", time, tag, threadName, prefix, message];
        }
        else {
            result = [[NSString alloc] initWithFormat:@"%@ [%@] [%@] %@", time, tag, prefix,message];
        }
        
    }
    return result;
}

- (NSString *) logTimeWith:(NSDate *)date{
    return [self.formater stringFromDate:NULL != date ? date:[NSDate date]];
}

@end

