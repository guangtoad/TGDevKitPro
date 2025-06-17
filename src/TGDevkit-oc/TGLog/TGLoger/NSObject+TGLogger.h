//
//  NSObject+TGLog.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//

#import <Foundation/Foundation.h>

#import "TGLogerCommonDefs.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TGLogger)

- (void) tg_logLevel:(TGLogLevel)level message:(NSString *)message;

- (void) tg_logInfo:(NSString *)mesage;

- (void) tg_logDebug:(NSString *)mesage;

- (void) tg_logWarn:(NSString *)mesage;

- (void) tg_logError:(NSString *)mesage;

- (void) tg_logCrash:(NSString *)mesage;

@end

NS_ASSUME_NONNULL_END
