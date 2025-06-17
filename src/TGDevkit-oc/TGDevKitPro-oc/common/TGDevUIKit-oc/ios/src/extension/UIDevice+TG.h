//
//  UIDevice+TG.h
//  TG-ObjC
//
//  Created by toad on 2019/4/2.
//  Copyright © 2019 toad. All rights reserved.
//

/** UIDevice TG扩展 */
#import <UIKit/UIKit.h>

#import <SystemConfiguration/SystemConfiguration.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <netdb.h>
#import "NSObject+TG.h"

@interface UIDevice (TG)

+ (NSString *) MACAddress;
+ (NSString *) IPAddress;
+ (BOOL) connectedToNetwork;

@end
