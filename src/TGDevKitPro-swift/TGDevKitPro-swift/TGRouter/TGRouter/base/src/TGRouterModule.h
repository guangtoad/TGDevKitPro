//
//  TGRouterModule.h
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TGRouterRequest.h"
#import "TGRouterResponse.h"

@interface TGRouterModule : NSObject
- (BOOL) beginRequest:(TGRouterRequest *)request sender:(NSObject *)sender;
@end
