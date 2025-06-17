//
//  TGLogger.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//

#import <Foundation/Foundation.h>
#import "TGLoggerStorageManager.h"

NS_ASSUME_NONNULL_BEGIN

@class TGLogger;

/// Logger 协议
@protocol TGLoggerDelegate <NSObject>

@required
- (void) tg_writeLogger:(TGLogger *)logger tag:(NSString * _Nonnull)tag level:(TGLogLevel)level date:(NSDate * _Nullable)date message:(NSString * _Nullable)message;

@end

@interface TGLogger : NSObject

/// 标签
@property (nonatomic,strong) NSString *tag;
/// 代理
@property (nonatomic,strong) id<TGLoggerDelegate> tg_delegate;

#pragma mark - 初始化

- (instancetype)initWithTag:(NSString *_Nonnull)tag delegate:(id<TGLoggerDelegate> _Nonnull)delegate;

#pragma mark - 写入

/// 写入日志
/// @param level 日志等级
/// @param message 信息
- (void) logLevel:(TGLogLevel)level message:(NSString *)message;

/// 写入调试日志
/// @param mesage 信息
- (void) debug:(NSString *)mesage;

/// 写入详细日志
/// @param mesage 信息
- (void) info:(NSString *)mesage;

/// 写入警告日志
/// @param mesage 信息
- (void) warn:(NSString *)mesage;

/// 写入错误日志
/// @param mesage 信息
- (void) error:(NSString *)mesage;

/// 写入崩溃日志
/// @param mesage 信息
- (void) crash:(NSString *)mesage;

- (instancetype) init __attribute__((unavailable("init not available, call TGLoggerManager createLogger")));

+ (instancetype) new __attribute__((unavailable("new not available, call TGLoggerManager createLogger")));

@end

NS_ASSUME_NONNULL_END
