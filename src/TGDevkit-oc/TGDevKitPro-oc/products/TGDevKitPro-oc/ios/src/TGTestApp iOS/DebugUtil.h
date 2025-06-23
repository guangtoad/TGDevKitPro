//
//  DebugUtil.h
//  TGTestApp iOS
//
//  Created by toad on 2022/08/03.
//

#import <Foundation/Foundation.h>

//#if __has_include(<TGLoger_iOS/TGLoggerManager.h>)
//#import <TGLoger_iOS/TGLoggerManager.h>
//#define INITDEBUGLOGER {\
//[TGLoggerManager initWithTag:@"elclog" level:TGLogLevelDebug storageType:TGLoggerStorageTypeLocalFile | TGLoggerStorageTypeSqllite storagePath:NULL fileName:NULL crashListening:true];\
//[TGLoggerManager pringSetting];\
//}
//#define DEBUGLOG(...) [TGLoggerManager tg_logDebug:[NSString stringWithFormat:__VA_ARGS__]]
//#else
//#define INITDEBUGLOGER {\
//}
//#define DEBUGLOG(...) [TGLoggerManager tg_logDebug:[NSString stringWithFormat:__VA_ARGS__]]
//#endif

NS_ASSUME_NONNULL_BEGIN

@interface DebugUtil : NSObject

@end

NS_ASSUME_NONNULL_END
