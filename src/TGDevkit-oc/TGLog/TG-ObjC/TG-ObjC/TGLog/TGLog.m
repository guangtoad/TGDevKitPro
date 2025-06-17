//
//  TGLog.m
//  TG-ObjC
//
//  Created by toad on 2019/5/27.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGLog.h"
#import "TGUtility.h"
@interface TGLog()

@property (nonatomic,assign) BOOL isDebug;

@end

@implementation TGLog


+ (TGLogItem)itemWithValue:(NSValue *)value{
    TGLogItem item;
    [value getValue:&item];
    return item;
}
+ (NSValue *)valueWithItem:(TGLogItem)item{
    NSValue *value = [NSValue value:&item withObjCType:@encode(TGLogItem)];
    return value;
}

- (NSMutableArray<NSValue *> *) logItems{
    if (!_logItems) {
        _logItems = [[NSMutableArray<NSValue *> alloc] init];
    }
    return _logItems;
}

- (id) init{
    if (self = [super init]) {
        _logid = [TGUtility createUUID];
//        __FUNCTION__
        
    }
    return self;
}

+ (BOOL) log:(NSString *)str level:(TGLogLevel)level{
    return true;
}
+ (BOOL) log:(NSString *)log{
    return [self log:log level:TGLogLevelInfo];
}
+ (BOOL) warning:(NSString *)log{
    return [self log:log level:TGLogLevelWarning];
}
+ (BOOL) error:(NSString *)log{
    return [self log:log level:TGLogLevelError];
}

@end

