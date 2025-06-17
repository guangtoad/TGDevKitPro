//
//  TGLogge.m
//  TG-ObjC
//
//  Created by toad on 2019/5/27.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGLogger.h"

@implementation TGLogger

- (NSMutableArray<TGLog *> *)logs{
    if (!_logs) {
        _logs = [[NSMutableArray<TGLog *> alloc] init];
    }
    return _logs;
}

- (id) init{
    if (self = [super init]) {
        
    }
    return self;
}

- (BOOL) write:(NSString *)log InPath:(NSString *)path{
    return false;
}
- (BOOL) write:(NSString *)log{
    return [self write:log InPath:@""];
}

- (NSString *) showLog:(TGLogLevel)level{
    return @"";
}

@end

