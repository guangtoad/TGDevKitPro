//
//  TGAlertController.h
//  TGObj
//
//  Created by toad on 15/9/23.
//  Copyright © 2015年 toad. All rights reserved.
//
#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#import "UIAlertController+TG.h"
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif
//#import "<#header#>"
@interface TGAlertController : UIAlertController

@end
