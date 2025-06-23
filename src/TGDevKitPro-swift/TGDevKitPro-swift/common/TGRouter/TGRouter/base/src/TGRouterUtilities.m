//
//  TGRouterUtilities.m
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGRouterUtilities.h"

@implementation TGRouterUtilities

+ (NSString *) URLStrWithScheme:(TGRouterScheme)scheme className:(NSString *)className{
    return [NSString stringWithFormat:@"%@://%@",scheme,className];
}

@end
