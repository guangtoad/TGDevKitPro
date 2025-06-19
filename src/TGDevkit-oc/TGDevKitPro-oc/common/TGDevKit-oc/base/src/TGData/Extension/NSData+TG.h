//
//  UIData+TG.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TG.h"

@interface NSData (TG)

- (id) jsonObjectoptions:(NSJSONReadingOptions)opt error:(NSError **)error;

@end
