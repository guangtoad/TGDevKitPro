//
//  TGObject.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TG.h"

@interface TGObject : NSObject
- (instancetype) initWithDictionary:(NSDictionary *)dic;
+ (NSString *) typeWithConvertFromObjc_property_t:(objc_property_t)property;
@end
