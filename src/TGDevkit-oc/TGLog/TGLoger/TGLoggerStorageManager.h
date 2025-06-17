//
//  TGLoggerStorageManager.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//

#import "TGLoggerStorage.h"
#import "TGLoggerStoreConsole.h"
#import "TGLoggerStoreLocalFile.h"
#import "TGLoggerStoreSqllite.h"

NS_ASSUME_NONNULL_BEGIN

/// 容器管理
@interface TGLoggerStorageManager : TGLoggerStorage

/// 容器类型
@property (nonatomic,assign) TGLoggerStorageType storageType;

#pragma mark - 初始化

/// 初始化
/// @param tag 标签
/// @param level 级别
/// @param storageType 容器类型
- (instancetype) initWithTag:(NSString *)tag level:(TGLogLevel)level storageType:(TGLoggerStorageType)storageType;

#pragma mark - 配置

/// 设置
/// @param writeLevel 级别
/// @param storageType 容器类型
- (void) setWriteLevel:(TGLogLevel)writeLevel storageType:(NSInteger)storageType;

#pragma mark - 写入
/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param storageType 容器类型
/// @param message 内容
- (void) writeTag:(NSString * _Nullable)tag level:(TGLogLevel)level date:(NSDate * _Nullable)date storageType:(NSUInteger)storageType message:(NSString * _Nullable)message;

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param message 内容
- (void) writeTag:(NSString * _Nullable)tag level:(TGLogLevel)level date:(NSDate * _Nullable)date message:(NSString * _Nullable)message ;

#pragma mark - 读取

/// 读取日志内容
/// @param tag 标签
/// @param level 级别
/// @param path 路径
/// @param storageType 容器类型
/// @remarks a
/// @return 日志内容
- (NSString *) readLogWithTag:(NSString *)tag level:(TGLogLevel)level path:(NSString *)path storageType:(NSUInteger)storageType;

#pragma mark - 
/// 格式化日志内容
/// @param tag 标签
/// @param level 级别
/// @param date 时间
/// @param message 内容
/// @return 格式化之后的内容
- (NSString *) formaterWithTag:(NSString * _Nullable)tag level:(TGLogLevel)level date:(NSDate * _Nullable)date message:(NSString * _Nullable)message;

@end

NS_ASSUME_NONNULL_END
