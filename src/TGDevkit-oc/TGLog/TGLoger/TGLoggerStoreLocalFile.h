//
//  LoggerStoreLocalFile.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  本地文件

#import "TGLoggerStorage.h"

NS_ASSUME_NONNULL_BEGIN

/// 日志文件容器
@interface TGLoggerStoreLocalFile : TGLoggerStorage

/// 日志目录路径
@property (nonatomic, copy, nullable) NSString *logPath;

/// 日志文件路径
@property (nonatomic, strong) NSString *logFilePath;

/// 初始化
/// @param level 级别
/// @param logPath 日志目录路径
/// @param logFilePath 日志文件路径
- (instancetype) initWithLogLevel:(TGLogLevel)level logPath:(NSString *)logPath logFilePath:(NSString *)logFilePath;

/// 初始化
/// @param level 级别
/// @param logPath 日志目录
- (instancetype) initWithLogLevel:(TGLogLevel)level logPath:(NSString *)logPath;

@end

NS_ASSUME_NONNULL_END
