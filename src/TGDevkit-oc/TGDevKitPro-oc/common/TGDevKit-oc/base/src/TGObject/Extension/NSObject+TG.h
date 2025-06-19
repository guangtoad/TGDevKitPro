//
//  NSObjet+TG.h
//  TGObj
//
//  Created by toad on 15/9/21.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>
#import "TGMacros.h"

@interface NSObject (TG_runtime)

+ (NSString *) typeWithConvertFromObjc_property_t:(objc_property_t)property;

@end

@interface NSObject (TG_Dictionary)

- (NSDictionary *) dictionaryValue;

@end

@interface NSObject (TG_Sqlite)

@end