//
//  UIDevice+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <SystemConfiguration/SystemConfiguration.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <netdb.h>

@interface UIDevice (TG)

+ (NSString *) MACAddress;
+ (NSString *) IPAddress;
+ (BOOL) connectedToNetwork;
+ (float) iOSVersion;

@end
