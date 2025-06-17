//
//  TGLogerStorage.m
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  日志容器

#import "TGLoggerStorage.h"

/// 日志容器
@interface TGLoggerStorage()


@end

/// 日志容器
@implementation TGLoggerStorage

#pragma mark - 懒加载

/// 标签
- (NSString *)tag{
    if (!_tag && _tag.length < 1) {
        _tag = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
    }
    return _tag;
}

#pragma mark - 配置

/// 设置
/// @param tag 标签
/// @param level 级别
- (void) setTag:(NSString *)tag level:(TGLogLevel)level{
    _writeLevel = level;
    _tag = tag;
}

/// 获取配置
- (__kindof NSDictionary *) getSetting{
    return [[NSMutableDictionary alloc] init];
}

#pragma mark - 初始化

/// 初始化
/// @param tag 标签
/// @param level 级别
- (instancetype)initWithTag:(NSString *)tag level:(TGLogLevel)level{
    self = [super init];
    if (self) {
        _writeLevel = level;
        _tag = [NSString stringWithString:tag];
    }
    return self;
}

/// 初始化
/// @param level 打印日志等级
- (instancetype)initWithLogLevel:(TGLogLevel)level{
    self = [self init];
    if (self) {
    }
    return self;
}

#pragma mark - 写入

/// 写入日志
/// @param tag 标签
/// @param level 日志等级
/// @param message 日志信息
- (BOOL) writeLogTag:(NSString * _Nonnull)tag level:(TGLogLevel)level message:(NSString * _Nullable)message{
    return level >= self.writeLevel;
}

/// 读取日志
/// @param tag 标签
/// @param level 级别
/// @param path 路径
- (NSString *) readLogWithTag:(NSString *)tag level:(TGLogLevel)level path:(NSString * _Nullable)path{
    return @"";
}

#pragma mark - 读取
/// 读取日志
- (NSString *) readLog{
    return [self readLogWithTag:self.tag level:self.writeLevel path:NULL];
}

#pragma mark - 清除

/// 清除指定时间以前的
/// @param date 时间
- (BOOL) clearBeforeDate:(NSDate *)date{
    return true;
}

/// 清除所有日志
- (BOOL) clearAll{
    return [self clearBeforeDate:[NSDate date]];
}

@end



