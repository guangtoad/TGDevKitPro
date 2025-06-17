//
//  TGMacro.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//

#import <Foundation/Foundation.h>
#import "TGLogerCommonDefs.h"

//#ifdef TGDE
//#ifdef TGLOGINIT(_TAG,_LEVEL) []

#ifdef TGLOGOPEN
    #if TGLOGOPEN == 1
        #define TGLOG(_LEVEL,_FORMAT, ...) [TGLoggerManager writelevel:_LEVEL message:[NSString stringWithFormat:@"%s [%d] %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:_FORMAT,##__VA_ARGS__]]]
    #else
        #define TGLOG(_LEVEL,_FORMAT, ...) ()
    #endif
#else
    #define TGLOG(_LEVEL,_FORMAT, ...) ()
#endif

#define TGLOGDEBUG(_FORMAT, ...) TGLOG(TGLogLevelDebug,_FORMAT,##__VA_ARGS__)
#define TGLOGINFO(_FORMAT, ...) TGLOG(TGLogLevelInfo,_FORMAT,##__VA_ARGS__)
#define TGLOGWARRY(_FORMAT, ...) TGLOG(TGLogLevelWarn,_FORMAT,##__VA_ARGS__)
#define TGLOGERROR(_FORMAT, ...) TGLOG(TGLogLevelError,_FORMAT,##__VA_ARGS__)
