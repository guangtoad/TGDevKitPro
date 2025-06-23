//
//  TGHttp.h
//  TGObj
//
//  Created by toad on 15/9/29.
//  Copyright © 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGMacros.h"

#if __has_include("AFNetworking.h")
#import "AFNetworking.h"
#define has_AFNetworking true
#else
#define has_AFNetworking false
#endif

@interface TGHttp : NSObject

@end
