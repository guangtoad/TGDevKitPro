//
//  TGLoggerManager.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  日志中心

#import <Foundation/Foundation.h>
#import "TGLogger.h"

NS_ASSUME_NONNULL_BEGIN

/// 日志中心
@interface TGLoggerManager : NSObject<TGLoggerDelegate>
/// 打印标签
@property (nonatomic,assign) BOOL printTag;
/// 打印线程
@property (nonatomic,assign) BOOL printT;
/// 标签
@property (nonatomic,strong) NSString *tag;

/// 获取单例
+ (instancetype)shareInstance;

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param message 信息
+ (void) writeTag:(NSString * _Nonnull)tag level:(TGLogLevel)level date:(NSDate *)date message:(NSString * _Nullable)message;

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param message 信息
+ (void) writeTag:(NSString * _Nonnull)tag level:(TGLogLevel)level  message:(NSString * _Nullable)message;

/// 写入日志
/// @param level 级别
/// @param message 信息
+ (void) writelevel:(TGLogLevel)level message:(NSString * _Nullable)message;

/// 读取日志
/// @param storageType 容器类型
/// @param uri 路径
+ (NSString *) readLogTxtWithstorageType:(TGLoggerStorageType)storageType uri:(NSString * _Nullable)uri;

/// 读取日志
/// @remarks 默认读取本地文件日志
/// @return 日志内容
+ (NSString *) readLogTxt;

/// 禁止 alloc 方法 防止非单例调用
+ (instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));

/// 禁止 init 方法 防止非单例调用
- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));

/// 禁止 new 方法 防止非单例调用
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

/// 初始化
/// @param tag 标签
/// @param level 界别
/// @param storageType 容器类型
/// @param logPath 日志目录
/// @param filePath 日志文件路径
/// @remarks 日志
/// @code
/// asdasd
/// @endcode
+ (BOOL) initWithTag:(NSString * _Nonnull)tag
               level:(TGLogLevel)level
         storageType:(NSUInteger)storageType
             logPath:(NSString * _Nullable)logPath
       localFilePath:(NSString * _Nullable)filePath;

/// 初始化
/// @param tag 标签
/// @param level 级别
+ (BOOL) initWithTag:(NSString * _Nonnull)tag
               level:(TGLogLevel)level;

/// 清空所有日志
+ (BOOL) clearAll;

/// 获取配置
+ (NSDictionary *) getSetting;

@end

NS_ASSUME_NONNULL_END
