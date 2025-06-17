//
//  TGLogger.m
//  TGLog
//
//  Created by toad on 2021/08/30.
//

#import "TGLogger.h"
#import "TGLoggerStorage.h"

@implementation TGLogger

- (instancetype)initWithTag:(NSString *_Nonnull)tag delegate:(id<TGLoggerDelegate> _Nonnull)delegate{
    self = [super init];
    if (self) {
        self.tag = tag;
        self.tg_delegate = delegate;
    }
    return self;
}

- (void) logLevel:(TGLogLevel)level message:(NSString *)message{
    if (nil !=  self.tg_delegate && [self.tg_delegate respondsToSelector:@selector(tg_writeLogger:tag:level:date:message:)]) {
        [self.tg_delegate tg_writeLogger:self tag:self.tag level:level date:NULL message:message];
    }
}

- (void) info:(NSString *)mesage{
    [self logLevel:TGLogLevelInfo message:mesage];
}

- (void) debug:(NSString *)mesage{
    [self logLevel:TGLogLevelDebug message:mesage];
}

- (void) warn:(NSString *)mesage{
    [self logLevel:TGLogLevelWarn message:mesage];
}

- (void) error:(NSString *)mesage{
    [self logLevel:TGLogLevelError message:mesage];
}

- (void) crash:(NSString *)mesage{
    [self logLevel:TGLogLevelCrash message:mesage];
}

@end
