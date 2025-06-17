//
//  TGRouterDefs.h
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef __cplusplus
#define UIKIT_EXTERN        extern "C" __attribute__((visibility ("default")))
#else
#define UIKIT_EXTERN            extern __attribute__((visibility ("default")))
#endif

typedef NSString *TGRouterKey NS_EXTENSIBLE_STRING_ENUM;
typedef NSString *TGRouterScheme NS_EXTENSIBLE_STRING_ENUM;

UIKIT_EXTERN const TGRouterScheme _Nonnull TGRouter_Scheme_Push;
UIKIT_EXTERN const TGRouterScheme _Nonnull TGRouter_Scheme_Present;
UIKIT_EXTERN const TGRouterScheme _Nonnull TGRouter_Scheme_Select;

UIKIT_EXTERN const TGRouterKey _Nonnull TGRouter_Key_NibName;
UIKIT_EXTERN const TGRouterKey _Nonnull TGRouter_Key_StoryboardName;
UIKIT_EXTERN const TGRouterKey _Nonnull TGRouter_Key_Identifier;
UIKIT_EXTERN const TGRouterKey _Nonnull TGRouter_Key_HidesBottomBar;
UIKIT_EXTERN const TGRouterKey _Nonnull TGRouter_Key_Animated;
UIKIT_EXTERN const TGRouterKey _Nonnull TGRouter_Key_Bundle;
UIKIT_EXTERN const TGRouterKey _Nonnull TGRouter_Key_Pop;


