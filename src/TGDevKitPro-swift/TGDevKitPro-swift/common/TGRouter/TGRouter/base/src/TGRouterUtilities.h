//
//  TGRouterUtilities.h
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGRouterDefs.h"
NS_ASSUME_NONNULL_BEGIN

@interface TGRouterUtilities : NSObject

+ (NSString *) URLStrWithScheme:(TGRouterScheme)scheme className:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
