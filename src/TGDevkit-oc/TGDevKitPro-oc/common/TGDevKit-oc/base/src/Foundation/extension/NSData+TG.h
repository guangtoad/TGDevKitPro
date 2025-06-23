//
//  UIData+TG.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TG.h"

/**
 NSData扩展
 */
@interface NSData (TG)

/**
 转换json obj
 
 @param opt Options
 @param error error
 @return obj
 */
- (id) jsonObjectoptions:(NSJSONReadingOptions)opt error:(NSError **)error;

@end
