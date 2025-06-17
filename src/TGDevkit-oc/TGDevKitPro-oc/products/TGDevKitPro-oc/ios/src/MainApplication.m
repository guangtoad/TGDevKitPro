//
//  MainApplication.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "MainApplication.h"

@implementation MainApplication
static MainApplication* _instance = nil;
 
+ (instancetype) shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
     
    return _instance ;
}
 
+ (id) allocWithZone:(struct _NSZone *)zone{
    return [MainApplication shareInstance] ;
}
 
- (id) copyWithZone:(struct _NSZone *)zone{
    return [MainApplication shareInstance] ;
}
 
- (void) doWillTerminate:(NSNotification *)notification{
    
}

- (void) didEnterBackground:(NSNotification *)notification{
    
}

- (void) registerNotification{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(doWillTerminate:) name:UIApplicationWillTerminateNotification object:NULL];
    [notificationCenter addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:NULL];
}

/// 验证资源文件
- (BOOL) resourceVerifyFiles{
    [CacheCenter getInstance];
    return true;
}

- (void) resourceUploadFiles:(MainApplicationCallBackBlock)uploadProgressBlock
           completionHandler:(MainApplicationCallBackBlock)completionHandler{
    if (NULL != completionHandler) {
        completionHandler(@"",@{},NULL);
    }
}

- (BOOL) resourceVerifyAndUploadFile:(MainApplicationCallBackBlock)uploadProgressBlock
                   completionHandler:(MainApplicationCallBackBlock)completionHandler{
    if (![self resourceVerifyFiles]) {
        [self resourceVerifyAndUploadFile:uploadProgressBlock completionHandler:completionHandler];
        return false;
    }
    return true;
}

/// 验证数据文件
- (BOOL) verifyDataFiles{
    return true;
}

@end
