//
//  TGLogerStorage.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  日志容器

#import <Foundation/Foundation.h>
#import "TGLogerCommonDefs.h"

NS_ASSUME_NONNULL_BEGIN

/// 日志容器
@interface TGLoggerStorage : NSObject

/// 标签
@property (nonatomic,strong) NSString *tag;
/// 日志
@property (nonatomic,assign) TGLogLevel writeLevel;

#pragma mark - 初始化

/// 初始化
/// @param tag 标签
/// @param level 级别
- (instancetype)initWithTag:(NSString * _Nonnull)tag level:(TGLogLevel)level;


/// 初始化
/// @param level 打印日志等级
- (instancetype)initWithLogLevel:(TGLogLevel)level;

#pragma mark - 配置

/// 设置
/// @param tag 标签
/// @param level 级别
- (void) setTag:(NSString *)tag level:(TGLogLevel)level;

/// 读取配置
- (__kindof NSDictionary *) getSetting;

#pragma mark - 写入

/// 写入日志
/// @param tag 标签
/// @param level 日志等级
/// @param message 日志信息
- (BOOL) writeLogTag:(NSString * _Nonnull)tag level:(TGLogLevel)level message:(NSString * _Nullable)message;

#pragma mark - 读取

/// 读取日志
/// @param tag 标签
/// @param level 级别
/// @param path 路径
- (NSString *) readLogWithTag:(NSString *)tag level:(TGLogLevel)level path:(NSString * _Nullable)path;

/// 读取日志
- (NSString *) readLog;

#pragma mark - 清理

/// 清除指定时间以前的
/// @param date 时间
- (BOOL) clearBeforeDate:(NSDate * _Nonnull)date;

/// 清除所有日志
- (BOOL) clearAll;

@end

NS_ASSUME_NONNULL_END
