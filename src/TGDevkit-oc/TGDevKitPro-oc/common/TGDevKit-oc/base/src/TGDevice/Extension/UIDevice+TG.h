//
//  UIDevice+TG.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
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
#import "NSObject+TG.h"

@interface UIDevice (TG)

+ (NSString *) MACAddress;
+ (NSString *) IPAddress;
+ (BOOL) connectedToNetwork;

@end
