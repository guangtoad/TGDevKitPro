//
//  CommonDef.h
//  TG Develop Tools
//
//  Created by toad on 2022/11/14.
//

#ifndef CommonDef_h
#define CommonDef_h
#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#ifdef __OBJC_GC__
    #error SDWebImage does not support Objective-C Garbage Collection
#endif

typedef NSString * _Nonnull TGKeyName NS_TYPED_EXTENSIBLE_ENUM;
//typedef NSString *NSNotificationName NS_TYPED_EXTENSIBLE_ENUM;

// Seems like TARGET_OS_MAC is always defined (on all platforms).
// To determine if we are running on macOS, use TARGET_OS_OSX in Xcode 8
#if TARGET_OS_OSX
    #import <Cocoa/Cocoa.h>
    #define TG_CONST_KEY_EXTERN APPKIT_EXTERN TGKeyName _Nonnull
    #define TG_CONST_VALUE_EXTERN TGKeyName
#else
    #define TG_CONST_KEY_EXTERN UIKIT_EXTERN const TGKeyName
    #define TG_CONST_VALUE_EXTERN const TGKeyName
#endif
 
#define KEY_AA @"asdasd"
#define KEY_AA @"asdasd"

TG_CONST_KEY_EXTERN PRE_KEY_FILE;
TG_CONST_KEY_EXTERN PRE_KEY_PATH;
TG_CONST_KEY_EXTERN PRE_KEY_HEX;
TG_CONST_KEY_EXTERN PRE_KEY_BASE64;
TG_CONST_KEY_EXTERN PRE_KEY_DATA;
TG_CONST_KEY_EXTERN PRE_KEY_RES;

TG_CONST_KEY_EXTERN TGKEY_GROUPS;
TG_CONST_KEY_EXTERN TGKEY_MENUS;
TG_CONST_KEY_EXTERN TGKEY_URL;
TG_CONST_KEY_EXTERN TGKEY_TITLE;
TG_CONST_KEY_EXTERN TGKEY_DESCRIPTION;
TG_CONST_KEY_EXTERN TGKEY_SUBTITLE;
TG_CONST_KEY_EXTERN TGKEY_ICON;
TG_CONST_KEY_EXTERN TGKEY_INFO;

#endif /* CommonDef_h */
