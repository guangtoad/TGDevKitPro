//
//  TGLoggerManager.m
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  日志中心

#import "TGLoggerManager.h"
#include <execinfo.h>

/// 日志中心
@interface TGLoggerManager()

@property (nonatomic,strong) TGLoggerStorageManager *storageManager;

@end

/// 日志中心
@implementation TGLoggerManager

#pragma mark - 懒加载

- (TGLoggerStorageManager *)storageManager{
    if (!_storageManager) {
        @synchronized (self) {
            if (!_storageManager) {
                _storageManager = [[TGLoggerStorageManager alloc] initWithTag:self.tag level:TGDefalueLevel storageType:TGDefalueStorageType];
            }
        }
    }
    return _storageManager;
}

#pragma mark - 单例

/// 静态单例
static TGLoggerManager *instance;

/// 获取单例
+ (instancetype)shareInstance {
    @synchronized(self) {
        if (instance == nil) {
            // 生成默认设置
            instance = [[TGLoggerManager alloc] init];
        }
    }
    return instance;
}

/// 加载异常委托
- (void) initExceptionHandle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 1、C/C++ 崩溃信息监听
        for (int i = 0; i < s_fatal_signal_num; ++i) {
            signal(s_fatal_signals[i], tg_singleCrashHandle);
        }
        // 2、iOS 崩溃信息监听
        NSSetUncaughtExceptionHandler(&x_uncaughtExceptionHandler);
    });
}

#pragma mark - 内部函数

/// 设置
/// @param tag 标签
/// @param level 级别
/// @param storageType 容器类型
- (void) setTag:(NSString *)tag level:(TGLogLevel)level storageType:(NSUInteger)storageType{
    [self.storageManager setWriteLevel:level storageType:storageType];
}

/// 设置级别 和 容器类型
/// @param level 级别
/// @param storageType 容器类型
- (void) setLevel:(TGLogLevel)level storageType:(NSUInteger)storageType{
    [self.storageManager setWriteLevel:level storageType:storageType];
}

/// 设置日志级别
/// @param level 级别
- (void) setLevel:(TGLogLevel)level{
    [self setLevel:level storageType:self.storageManager.storageType];
}

/// 设置日志目录
/// @param dirPath 日志目录
/// @param fielPath 日志文件
- (void) setLogPath:(NSString *)dirPath filePath:(NSString *)fielPath{
    
}

/// 设置
/// @param tag 标签
/// @param level 级别
/// @param storageType 容器类型
/// @param logPath 日志目录
/// @param filePath 日志路径
- (BOOL) setupTag:(NSString * _Nonnull)tag
            level:(TGLogLevel)level
      storageType:(NSUInteger)storageType
          logPath:(NSString *)logPath
    localFilePath:(NSString *)filePath{
    if (NULL != tag) {
        _tag = tag;
    }
    
    [self setLevel:level storageType:storageType];
    [self setLogPath:logPath filePath:filePath];
    
    return false;
}

/// 初始化
/// @param tag 标签
/// @param level 级别
/// @param storageType 容器类型
/// @param logPath 日志目录
/// @param filePath 日志路径
- (instancetype) initWithTag:(NSString * _Nonnull)tag
                       level:(TGLogLevel)level
                 storageType:(NSUInteger)storageType
                     logPath:(NSString * _Nullable)logPath
               localFilePath:(NSString * _Nullable)filePath{
    self = [super init];
    if (self) {
        [self setupTag:tag level:level storageType:storageType logPath:logPath localFilePath:filePath];
    }
    return self;
}

/// 初始化默认设置
- (instancetype)init{
    NSString *tag = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
    self = [self initWithTag:tag level:TGDefalueLevel storageType:TGDefalueStorageType logPath:NULL localFilePath:NULL];
    if (self) {
        
    }
    return self;
}

/// 写入日志
/// @param tag 标签
/// @param level 日志级别
/// @param date 时间
/// @param message 信息
- (void) writeTag:(NSString * _Nonnull)tag level:(TGLogLevel)level date:(NSDate *)date message:(NSString * _Nullable)message{
    
    [self.storageManager writeTag:tag level:level date:date message:message];
}

/// 写入日志
/// @param tag 标签
/// @param level 日志级别
/// @param message 信息
- (void) writeTag:(NSString * _Nonnull)tag level:(TGLogLevel)level  message:(NSString * _Nullable)message{
    [self.storageManager writeTag:tag level:level date:[NSDate date] message:message];
}

/// 写入日志
/// @param level 级别
/// @param message 信息
- (void) writelevel:(TGLogLevel)level  message:(NSString * _Nullable)message{
    [self writeTag:self.tag level:level date:[NSDate date] message:message];
}

- (NSDictionary *) getSetting{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (![dict isKindOfClass:[NSMutableDictionary class]]) {
        dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    }
    
    [dict setValuesForKeysWithDictionary:[self.storageManager getSetting]];
    return dict;
}
/// 输出设置
- (void) pringSetting{
    NSMutableString *pringStr = [[NSMutableString alloc] init];
    [pringStr appendFormat:@"Tag: %@\n",self.tag];
    
    NSMutableArray *storageTypes = [[NSMutableArray alloc] init];
    if ((self.storageManager.storageType & TGLoggerStorageTypeConsle) == TGLoggerStorageTypeConsle) {
        [storageTypes addObject:@"Consle"];
    }
    
    if ((self.storageManager.storageType & TGLoggerStorageTypeLocalFile) == TGLoggerStorageTypeLocalFile) {
        [storageTypes addObject:@"LocalFile"];
    }
    
    if ((self.storageManager.storageType & TGLoggerStorageTypeSqllite) == TGLoggerStorageTypeSqllite) {
        [storageTypes addObject:@"Sqllit"];
    }
    
    [pringStr appendFormat:@"Manager Level: %ld\n",(long)self.storageManager.writeLevel];
    [pringStr appendFormat:@"Storage Type: %@\n",[storageTypes componentsJoinedByString:@" | "]];
    NSDictionary *dict = [self getSetting];
    for (int i = 0; i < [[dict allKeys] count]; i++) {
        NSString *key = [[dict allKeys] objectAtIndex:i];
        NSString *value = [dict objectForKey:key];
        [pringStr appendFormat:@"%@: %@\n",key,value];
    }
    [self.storageManager writeTag:self.tag level:self.storageManager.writeLevel date:[NSDate date] storageType:TGLoggerStorageTypeConsle message:[NSString stringWithFormat:@"\n**********StorageManager init************* \n%@\n*********************************",pringStr]];
}

- (NSString *) readLogTxtWithstorageType:(TGLoggerStorageType)storageType uri:(NSString * _Nullable)uri{
    return [self.storageManager readLogWithTag:self.tag level:TGLogLevelDebug path:uri storageType:storageType];
}
- (NSString *) readLogTxt{
    return [self readLogTxtWithstorageType:TGLoggerStorageTypeLocalFile uri:NULL];
}

- (TGLogger *) createLoggerWithTag:(NSString * _Nonnull)tag{
    return [[TGLogger alloc] initWithTag:tag delegate:self];
}

- (TGLogger *) createLogger{
    return [self createLoggerWithTag:self.tag];
}

#pragma mark - System Exception Handler

NSArray<NSString *>* tg_backtrace(void) {
    // 崩溃堆栈信息
    // 指针列表
    void* callstack[128];
    // backtrace用来获取当前线程的调用堆栈，获取的信息存放在这里的callstack中
    // 128用来指定当前的buffer中可以保存多少个void*元素
    // 返回值是实际获取的指针个数
    int frames = backtrace(callstack, 128);
    // backtrace_symbols将从backtrace函数获取的信息转化为一个字符串数组
    // 返回一个指向字符串数组的指针
    // 每个字符串包含了一个相对于callstack中对应元素的可打印信息，包括函数名、偏移地址、实际返回地址
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray<NSString *> *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return [backtrace copy];
}

void x_uncaughtExceptionHandler(NSException *exception) {
    // 堆栈数据
    NSArray<NSString *> *callStackSymbolsArr = [exception callStackSymbols];
    tg_writeLogCrash(exception, callStackSymbolsArr);
}

void tg_singleCrashHandle(int signal) {
    // 捕获信号崩溃信息
    NSArray<NSString *> *callStack = tg_backtrace();
    NSString *description = [NSString stringWithFormat:@"Signal %d was raised!",signal];
    NSString *signalName = [NSString stringWithFormat:@"%d",signal];
    for (int i = 0; i < s_fatal_signal_num; ++i) {
        if (s_fatal_signals[i] == signal) {
            description = [NSString stringWithFormat:@"Signal %s was raised!",s_fatal_signal_names[i]];
            signalName = [NSString stringWithFormat:@"%s(%d)",s_fatal_signal_names[i],signal];
            break;
        }
    }
    tg_writeLogCrash([NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                                              reason:description
                                            userInfo:@{UncaughtExceptionHandlerSignalName : signalName}], callStack);
}

NSString* x_getMainCallStackSymbolMessageWithCallStackSymbolString(NSArray<NSString *> *callStackSymbolsArr) {
    // 当前项目名称
    NSString *executableFile = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleExecutableKey];
    
    // 函数栈中关于当前项目的函数
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",executableFile];
    NSArray<NSString *> *projectMethodStackSymbols = [callStackSymbolsArr filteredArrayUsingPredicate:predicate];
    
    // 函数栈中关于当前项目的函数 +[类名 方法名] 或者 -[类名 方法名]
    __block NSMutableString *mainCallStackSymbolMsg = [[NSMutableString alloc] init];
    
    // 匹配出来的格式为 +[类名 方法名] 或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    for (int index = (int)projectMethodStackSymbols.count - 1; index >= 0; index --) {
        NSString *callStackSymbolString = projectMethodStackSymbols[index];
        [regularExp enumerateMatchesInString:callStackSymbolString options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolString.length) usingBlock:^(NSTextCheckingResult *_Nullable result, NSMatchingFlags flags, BOOL *_Nonnull stop) {
            if (result) {
                NSString *msg = [callStackSymbolString substringWithRange:result.range];
                [mainCallStackSymbolMsg appendFormat:@"\n\t%@",msg];
                *stop = YES;
            }
        }];
    }
    return mainCallStackSymbolMsg;
}

void tg_writeLogCrash(NSException *exception, NSArray<NSString *> *callStacks) {
    
    // 崩溃位置定位
    NSString *location = x_getMainCallStackSymbolMessageWithCallStackSymbolString(callStacks);
    if (!location.length) {
        location = @"崩溃方法定位失败,请您查看函数调用栈来查找crash原因";
    }
    // 崩溃时间
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    NSString *date = [formater stringFromDate:[NSDate date]];
    NSMutableString *recordLog = [[NSMutableString alloc] init];
    
    // 应用信息
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    // 崩溃信息
    [recordLog appendFormat:@"\n------------------ Crash Information Start ------------------\n"];
    [recordLog appendFormat:@"崩溃时间: %@\n",date];
    [recordLog appendFormat:@"应用信息: %@ %@(%@)\n",appName, version, build];
    //        [recordLog appendFormat:@"设备型号: %@\n",[UIDevice currentDevice].model];
    //        [recordLog appendFormat:@"系统版本: %@ %@\n",[UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
    [recordLog appendFormat:@"崩溃类型: %@\n",exception.name];
    [recordLog appendFormat:@"崩溃原因: %@\n",exception.reason];
    [recordLog appendFormat:@"额外信息: %@\n",exception.userInfo];
    [recordLog appendFormat:@"崩溃定位: %@\n",location];
    [recordLog appendFormat:@"函数堆栈: \n%@\n",callStacks];
    [recordLog appendFormat:@"------------------- Crash Information End -------------------\n\n"];
        
        // 主线程记录日志
//        [DigitalXLogCtrl performSelectorOnMainThread:@selector(recordLog:) withObject:recordLog waitUntilDone:YES];
//    }
}


#pragma mark - 公开方法

/// 初始化
/// @param tag 标签
/// @param level 界别
/// @param storageType 容器类型
/// @param logPath 日志目录
/// @param filePath 日志文件路径
+ (BOOL) initWithTag:(NSString * _Nonnull)tag
               level:(TGLogLevel)level
         storageType:(NSUInteger)storageType
             logPath:(NSString * _Nullable)logPath
       localFilePath:(NSString * _Nullable)filePath{
    typeof(self) manager = [[self class] shareInstance];
    BOOL resutl = [manager setupTag:tag level:level storageType:storageType logPath:logPath localFilePath:filePath];
    
    [manager pringSetting];
    return resutl;
}

/// 初始化
/// @param tag 标签
/// @param level 级别
+ (BOOL) initWithTag:(NSString * _Nonnull)tag
               level:(TGLogLevel)level{
    return [[self class] initWithTag:tag level:level storageType:TGDefalueStorageType logPath:NULL localFilePath:NULL];
}
/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param message 信息
+ (void) writeTag:(NSString * _Nonnull)tag level:(TGLogLevel)level date:(NSDate *)date message:(NSString * _Nullable)message{
    [[[self class] shareInstance] writeTag:tag level:level date:date message:message];
}

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param message 信息
+ (void) writeTag:(NSString * _Nonnull)tag level:(TGLogLevel)level  message:(NSString * _Nullable)message{
    [[[self class] shareInstance] writeTag:tag level:level message:message];
}

/// 写入日志
/// @param level 级别
/// @param message 信息
+ (void) writelevel:(TGLogLevel)level message:(NSString * _Nullable)message{
    [[[self class] shareInstance] writelevel:level message:message];
}

+ (TGLogger *) createLogger{
    return [[self class] createLoggerWithTag:[[[self class] shareInstance] tag]];
}

+ (TGLogger *) createLoggerWithTag:(NSString *)tag{
    return [[[self class] shareInstance] createLoggerWithTag:tag];
}

+ (NSString *) readLogTxtWithstorageType:(TGLoggerStorageType)storageType uri:(NSString * _Nullable)uri{
    return [[[self class] shareInstance] readLogTxtWithstorageType:storageType uri:uri];
}

/// 读取日志
+ (NSString *) readLogTxt{
    return [[[self class] shareInstance] readLogTxt];
}

/// 清空所有日志
- (BOOL) clearAll{
    return [self.storageManager clearAll];
}

/// 清空之前时间以前的日志
/// @param date 时间
- (BOOL) clearBefoer:(NSDate *)date{
    return [self.storageManager clearAll];
}

/// 清空所有日志
+ (BOOL) clearAll{
    return [[[self class] shareInstance] clearAll];
}

/// 获取配置
+ (NSDictionary *) getSetting{
    return [[[self class] shareInstance] getSetting];
}

/// 输出设置
+ (void) pringSetting{
    [[[self class] shareInstance] pringSetting];
}

#pragma mark - TGLoggerDelegatet

- (void) tg_writeLogger:(TGLogger *)logger tag:(NSString *)tag level:(TGLogLevel)level date:(NSDate *)date message:(NSString *)message{
    [self writeTag:tag level:level date:date message:message];
}

@end
