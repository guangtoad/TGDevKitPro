//
//  UIView+HttpClinet.m
//  SKB
//
//  Created by toad on 2019/5/20.
//  Copyright © 2019 toad. All rights reserved.
//  

#import "UIView+HttpClient.h"

@implementation UIView (HttpClinet)

- (NSData *) requestData{
    return nil;
}

- (BOOL) willBeginReqeust{
    return true;
}

- (BOOL) didEndReqeust{
    return true;
}

- (BOOL) post:(NSString *)apiStr host:(NSString *)host header:(NSDictionary *)head data:(NSData *)data{
    if (![self willBeginReqeust]) {
        return false;
    }
    BOOL ret = true;
    return ret;
}

@end
