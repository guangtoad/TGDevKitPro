//
//  TGKitPrefix.h
//  TGDevelopToolsApp
//
//  Created by toad on 2024/1/4.
//

#ifndef TGKitPrefix_h
#define TGKitPrefix_h

#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#if TARGET_OS_IOS
    #import <UIKit/UIKit.h>
    #import "MJRefresh.h"
#elif TARGET_OS_OSX
    #import <Cocoa/Cocoa.h>
#else
    #error unknow OS
#endif

#import <SDWebImage/SDWebImage.h>

#endif /* TGKitPrefix_h */
