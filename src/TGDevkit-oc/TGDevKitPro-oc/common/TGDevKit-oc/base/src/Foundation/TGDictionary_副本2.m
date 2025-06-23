//
//  TGDictionary.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "TGDictionary.h"

@implementation TGDictionary

@end

@implementation TGDMutableDictionary

- (void) setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject != nil) {
        return [super setObject:anObject forKey:aKey];
    }
    return [super setObject:@"" forKey:aKey];
}

@end
