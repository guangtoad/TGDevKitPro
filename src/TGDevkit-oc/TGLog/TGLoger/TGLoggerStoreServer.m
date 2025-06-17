//
//  TGLoggerStoreServer.m
//  TGLog
//
//  Created by toad on 2021/09/01.
//
//  服务器

#import "TGLoggerStoreServer.h"

@interface TGLoggerStoreServer()

/// 上传线程
@property (nonatomic, nonnull) dispatch_queue_t uploadQueue;

@end

@implementation TGLoggerStoreServer

- (BOOL) writeLogTag:(NSString *)tag level:(TGLogLevel)level message:(NSString *)message{
    if (NULL != self.handler) {
        
    }
    return true;
}

@end
