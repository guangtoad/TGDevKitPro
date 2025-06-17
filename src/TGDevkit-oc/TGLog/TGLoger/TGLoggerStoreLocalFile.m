//
//  LoggerStoreLocalFile.m
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  本地文件

#import "TGLoggerStoreLocalFile.h"

/// 日志文件容器
@interface TGLoggerStoreLocalFile () {
    NSString *_logFilePath;
}

/// 输出流
@property (nonatomic, strong, nullable) NSOutputStream *outputStream;
/// 写入日志线程
@property (nonatomic, nonnull) dispatch_queue_t writeQueue;

@end

/// 日志文件容器
@implementation TGLoggerStoreLocalFile

#pragma mark - 懒加载

/// 日志文件名
- (NSString *) fileName{
    return [self.tag stringByAppendingString:@".log"];
}

/// 日志路径
- (NSString *) logFilePath{
    if (!_logFilePath) {
        [self setLogFilePath:[self fileName]];
    }
    return _logFilePath;
}

/// 写入日志线程
- (dispatch_queue_t) writeQueue {
    if (nil == _writeQueue) {
        @synchronized (self) {
            if (nil == _writeQueue) {
                _writeQueue = dispatch_queue_create("TGLog.Write.Queue", DISPATCH_QUEUE_SERIAL);
            }
        }
    }
    return _writeQueue;
}

/// 输出流
- (NSOutputStream *) outputStream{
    if (!_outputStream) {
        [self openStream];
    }
    return _outputStream;
}

/// 日志目录
- (NSString *) logPath{
    if (!_logPath) {
        @synchronized (self) {
            if (!_logPath) {
                NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                _logPath = [documentPath stringByAppendingPathComponent:@"TGLogs"];
            }
        }
    }
    return _logPath;
}

#pragma mark - 初始化

/// 初始化
/// @param level 级别
/// @param logPath 日志目录路径
/// @param logFilePath 日志文件路径
- (instancetype) initWithLogLevel:(TGLogLevel)level logPath:(NSString *)logPath logFilePath:(NSString *)logFilePath{
    self = [self initWithLogLevel:level];
    _logPath = [NSString stringWithString:logPath];
    [self setLogFilePath:logFilePath];
    if (self) {
        
    }
    return self;
}

/// 初始化
/// @param level 级别
/// @param logPath 日志目录
- (instancetype) initWithLogLevel:(TGLogLevel)level logPath:(NSString *)logPath{
    self = [self initWithLogLevel:level];
    _logPath = [NSString stringWithString:logPath];
    if (self) {
        
    }
    return self;
}

#pragma mark - 配置

/// 设置日志路径
/// @param logFilePath 日志路径
- (void) setLogFilePath:(NSString *)logFilePath{
    
    
    if (!logFilePath) {
        _logFilePath = [logFilePath stringByAppendingPathComponent:[self fileName]];
    }
    else {
        NSString *tempPath =[logFilePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (tempPath.isAbsolutePath) {
            _logFilePath = logFilePath;
        }
        else if (tempPath.length > 0) {
            
            _logFilePath = [self.logPath stringByAppendingPathComponent:logFilePath];
        }
        else {
            _logFilePath = [self.logPath stringByAppendingPathComponent:[self fileName]];
        }
    }
        
    
    
}

/// 获取配置
- (__kindof NSDictionary *)getSetting{
    NSDictionary *dict = [super getSetting];
    if (![dict isKindOfClass:[NSMutableDictionary class]]) {
        dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    }
    [dict setValue:@(self.writeLevel) forKey:@"Local File Level"];
    [dict setValue:self.logPath forKey:@"Local Log Path"];
    [dict setValue:self.logFilePath forKey:@"Local File Path"];
    return dict;
}

#pragma mark - 写入

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param message 信息
- (BOOL) writeLogTag:(NSString *)tag level:(TGLogLevel)level message:(NSString *)message{
    if ([super writeLogTag:tag level:level message:message]) {
        __weak typeof(self) wself = self;
        dispatch_async(self.writeQueue, ^{
            __strong typeof(wself) strongSelf = wself;
            [strongSelf writeStreamLog:message];
        });
    }
    return false;;
}

/// 写入日志到文件
/// @param logMessage 信息
- (void) writeStreamLog:(NSString *)logMessage {
    // 记录日志
    @autoreleasepool {
        NSError *error = self.outputStream.streamError;
        if (NULL != error) {
            [self openStream];
        }
        // 写入文件
        NSData *recordD = [[NSString stringWithFormat:@"%@\n",logMessage] dataUsingEncoding:NSUTF8StringEncoding];
        [self.outputStream write:recordD.bytes maxLength:recordD.length];
    }
}

#pragma mark - 读取

/// 读取日志
/// @param tag 标签
/// @param level 级别
/// @param path 路径
- (NSString *) readLogWithTag:(NSString *)tag level:(TGLogLevel)level path:(NSString *)path{
    NSString *result = NULL;
    NSString *tempPath = path;
    if (NULL == tempPath || tempPath.length > 0) {
        tempPath = self.logFilePath;
    }
    NSError *error = NULL;
    result = [NSString stringWithContentsOfFile:tempPath encoding:NSUTF8StringEncoding error:&error];
    if (NULL != error) {
        return [NSString stringWithFormat:@"File Path :%@\nError:%@",path,error];
    }
    return result;
    
    return result;
}

/// 读取日志
- (NSString *) readLog{
    return [self readLogWithTag:self.tag level:self.writeLevel path:self.logFilePath];
}

#pragma mark - 清理

/// 清空指定时间前的日志
/// @param date 时间
- (BOOL) clearBeforeDate:(NSDate *)date{
    return [self clearAll];
}

/// 清空所有
- (BOOL) clearAll{
    @synchronized(self) {
        [self closeStream];
        
        // 获取文件夹下所有文件
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
     
        
        [fileManager removeItemAtPath:self.logFilePath error:&error];
        
        if (error) {
            return false;
        }
        
        [fileManager changeCurrentDirectoryPath:self.logPath];
        
        NSArray<NSString *> *contents = [fileManager contentsOfDirectoryAtPath:self.logPath error:&error];
        
        for (int i = 0 ; i < [contents count]; i++) {
            NSString *content = contents[i];
            NSString *deletePath = [self.logPath  stringByAppendingPathComponent:content];
            BOOL result = [fileManager removeItemAtPath:deletePath error:&error];
            if (error || !result) {
            }
            else {
            }
        }
        [self openStream];
    }
    return false;
}

#pragma mark -

/// 开启输出流
- (void) openStream{
    @synchronized(self) {
        
        [self closeStream];
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *tempPath = self.logFilePath;
        if (self.logFilePath.isAbsolutePath) {
           
        }
        else {
            tempPath = [self.logPath stringByAppendingString:self.logFilePath];
        }
        
        BOOL exist = [fileManager fileExistsAtPath:tempPath];
        if (exist) {
            _outputStream = [[NSOutputStream alloc] initToFileAtPath:tempPath append:YES];
            return;
        }
        
        exist = [[NSFileManager defaultManager] fileExistsAtPath:[tempPath stringByDeletingLastPathComponent] isDirectory:&isDir];
        if (exist) {
            // 路径存在
            if (!isDir) {
                return;
            }
        }
        else {
            // 路径不存在，创建路径
            NSError *error;
            BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:[tempPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:&error];
            if (error || !result) {
                return;
            }
            else {
            }
        }
        _outputStream = [[NSOutputStream alloc] initToFileAtPath:tempPath append:YES];
        [_outputStream open];
    }
}

/// 关闭输出流
- (void) closeStream{
    if (NULL != _outputStream) {
        [_outputStream close];
        _outputStream = NULL;
    }
}

#pragma mark - 销毁

/// 销毁
- (void) dealloc{
    [self closeStream];
}

@end
