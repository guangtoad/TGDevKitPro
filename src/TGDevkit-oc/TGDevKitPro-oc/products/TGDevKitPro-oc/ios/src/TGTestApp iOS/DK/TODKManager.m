//
//  TODKManager.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/15.
//

#import "TODKManager.h"

#import <DKModuleKit/DKModuleKit.h>
@implementation TODKManager
+ (instancetype)shareDKManager{
    static TODKManager *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}

- (void)DK_init{
    @try {
        @module_call(DKPlugin.initPlugin);
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
}
@end
