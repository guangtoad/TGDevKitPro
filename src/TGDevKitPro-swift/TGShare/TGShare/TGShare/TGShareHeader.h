//
//  TGShareHeader.h
//  TGSahre
//
//  Created by home on 2018/4/14.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGShareKEYs.h"
#if __has_include(<TencentOpenAPI/TencentOAuth.h>)
#define TGShare_Open_Tencent true
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#else
#error TencentOpenAPI
#endif


#if __has_include("WXApi.h")
#import "WXApi.h"
#import "WechatAuthSDK.h"
#define TGShare_Open_Wechat true
#else
#error WXApi.h
#endif


#if __has_include("WeiboSDK.h")
#import "WeiboSDK.h"
#import "WBHttpRequest.h"
#define TGShare_Open_Wechat true
#else
#error WeiboSDK.h
#endif
