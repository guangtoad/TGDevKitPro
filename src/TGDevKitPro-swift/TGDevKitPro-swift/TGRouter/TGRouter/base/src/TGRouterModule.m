//
//  TGRouterModule.m
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGRouterModule.h"

@implementation TGRouterModule

- (BOOL) beginRequest:(TGRouterRequest *)request sender:(NSObject *)sender{
    return true;
}
- (BOOL) endReqeust:(TGRouterRequest *)reqeust sender:(NSObject *)sender{
    return true;
}

@end
