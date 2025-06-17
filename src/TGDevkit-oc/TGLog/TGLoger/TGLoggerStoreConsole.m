//
//  TGLogerStoreConsole.m
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  控制台输出

#import "TGLoggerStoreConsole.h"

@implementation TGLoggerStoreConsole

#pragma mark - 写入

/// 写入日志
/// @param tag 标签
/// @param level 级别
/// @param message 内容
- (BOOL) writeLogTag:(NSString *)tag level:(TGLogLevel)level message:(NSString *)message{
    if ([super writeLogTag:tag level:level message:message]) {
        NSLog(@"%@", message);
        return false;
    }
    return true;
}

#pragma mark - 配置

/// 获取设置
- (__kindof NSDictionary *)getSetting{
    NSDictionary *dict = [super getSetting];
    if (![dict isKindOfClass:[NSMutableDictionary class]]) {
        dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    }
    [dict setValue:@(self.writeLevel) forKey:@"Console Level"];
    return dict;
}

@end
