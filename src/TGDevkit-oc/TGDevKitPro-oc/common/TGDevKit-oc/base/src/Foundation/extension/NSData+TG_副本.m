//
//  UIData+TG.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "NSData+TG.h"

@implementation NSData (TG)

- (id) jsonObjectoptions:(NSJSONReadingOptions)opt error:(NSError **)error{
    return [NSJSONSerialization JSONObjectWithData:self options:opt error:error];
}


- (NSData *) subDataWithLoc:(NSUInteger)loc len:(NSUInteger)len{
    if ((loc + len) <= self.length) {
        return [self subdataWithRange:NSMakeRange(loc, len)];
    }
    return NULL;
}
- (NSString *) substringWithLoc:(NSUInteger)loc len:(NSUInteger)len{
    if ((loc + len) <= self.length) {
        return [self substringWithRange:NSMakeRange(loc, len)];
    }
    return NULL;
}

@end
