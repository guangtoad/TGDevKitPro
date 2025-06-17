//
//  LoggerStoreSqllite.m
//  TGLog
//
//  Created by toad on 2021/08/30.
//
//  本地数据库

#import "TGLoggerStoreSqllite.h"

@implementation TGLoggerStoreSqllite

- (__kindof NSDictionary *)getSetting{
    NSDictionary *dict = [super getSetting];
    if (![dict isKindOfClass:[NSMutableDictionary class]]) {
        dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    }
    return dict;
}

@end
