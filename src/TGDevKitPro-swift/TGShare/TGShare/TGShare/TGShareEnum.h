//
//  TGShareEnum.h
//  TGSahre
//
//  Created by home on 2018/4/14.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ASDASD

 - TGShareSeccue: ASDASD
 */
typedef NS_ENUM(NSInteger,TGShareCode) {
    TGShareSeccue = 0
};

/**
 ASDASD

 - ShareToTypeWXSceneSession: ASDASDASD
 */
typedef NS_ENUM(NSInteger,TGShareToType) {
    ShareToTypeWXSceneSession  = 0,        /**< 聊天界面    */
    ShareToTypeWXSceneTimeline,   /**< 微信朋友圈      */
    ShareToTypeTencent, /**< 腾讯      */
    ShareTypeSinaWeibo, /**< 微博      */
};

