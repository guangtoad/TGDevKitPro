//
//  TGLog.h
//  TG-ObjC
//
//  Created by toad on 2019/5/27.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TGLogLevel){
    TGLogLevelInfo=0,
    TGLogLevelWarning=1,
    TGLogLevelError=2,
};

typedef struct {
    NSDate *time;
    NSString *msg;
    TGLogLevel level;
}TGLogItem;

@interface TGLog : NSObject

@property (nonatomic,strong,readonly) NSString *logid;
@property (nonatomic,strong) NSMutableArray<NSValue *> *logItems;

@end

#if DEBUG
#define TGLOG(__head, ...) NSLog(@"[%@][%@][%s %s][%s][%s][%d] %@" , __head , @"123" , __DATE__ , __TIME__ , __FILE__ , __PRETTY_FUNCTION__ , __LINE__ , [NSString stringWithFormat:__VA_ARGS__])
#else
#define TGLOG(__head, ...) do { } while (0)
#endif

#define TGLOGERROR(...) TGLOG(@"Error:", __VA_ARGS__)
#define TGLOGWARNING(...) TGLOG(@"Waring:", __VA_ARGS__)
#define TGLOGINFO(...) TGLOG(@"Info:", __VA_ARGS__)
