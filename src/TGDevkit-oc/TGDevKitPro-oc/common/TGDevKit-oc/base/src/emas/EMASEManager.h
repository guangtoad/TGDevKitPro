//
//  EMASEManager.h
//  EMASTest
//
//  Created by toad on 2021/12/02.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UNUserNotificationCenter.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMASEManager : NSObject

+ (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

+ (instancetype)sharedSingleton;
+ (void) registerSDKWithAppliction:(UIApplication *)application;
@end

NS_ASSUME_NONNULL_END
