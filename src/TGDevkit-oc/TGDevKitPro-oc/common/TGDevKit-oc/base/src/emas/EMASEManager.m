//
//  EMASEManager.m
//  EMASTest
//
//  Created by toad on 2021/12/02.
//

#import "EMASEManager.h"

#import <CloudPushSDK/CloudPushSDK.h>

@interface EMASEManager()<UNUserNotificationCenterDelegate>

@end

@implementation EMASEManager

static EMASEManager *_instance;

+ (instancetype)sharedSingleton {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"CloudPushSDK registerDevice success");
        }
        else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}

- (void) registerAPNS:(UIApplication *)application {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // granted
            NSLog(@"User authored notification.");
            // 向APNs注册，获取deviceToken
            dispatch_async(dispatch_get_main_queue(), ^{
                [application registerForRemoteNotifications];
            });
        } else {
            // not granted
            NSLog(@"User denied notification.");
        }
    }];
}

- (void) registerSDKWithAppliction:(UIApplication *)application{
    
    NSString *appKey = @"333475115";
    NSString *appSecret = @"df841ebdc23144819397d51d565073c8";
    [self registerAPNS:application];
    [CloudPushSDK asyncInit:appKey appSecret:appSecret callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            [CloudPushSDK getDeviceId];
            NSLog(@"Push SDK init success");
            NSLog(@"[CloudPushSDK getDeviceId]:%@",[CloudPushSDK getDeviceId]);
        }
        else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

+ (void) registerSDKWithAppliction:(UIApplication *)application{
    [[[self class] sharedSingleton] registerSDKWithAppliction:application];
}

@end
