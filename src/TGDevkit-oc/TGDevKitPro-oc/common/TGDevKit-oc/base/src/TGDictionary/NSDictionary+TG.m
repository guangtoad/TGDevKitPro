//
//  NSDictionary+TG.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "NSDictionary+TG.h"

@implementation NSDictionary (TG)

- (NSString *) my_description{
    NSString *desc = [self description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}
- (id) clasModel:(Class)obj_class Key:(id)aKey{
    id obj = [self objectForKey:aKey];
    if (obj != nil &&  [[obj class] isSubclassOfClass:obj_class]) {
        return obj;
    }
    return nil;
}
- (NSString *) stringValueForKey:(id)aKey{
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    if ([obj respondsToSelector:@selector(stringValue)]) {
        return [obj stringValue];
    }
    return TG_NULL_VALUE_STR;
}
- (NSInteger) integerValueForKey:(id)aKey{
    id obj = [self objectForKey:aKey];
    if ([obj respondsToSelector:@selector(integerValue)]) {
        return [obj integerValue];
    }
    return TG_NULL_VALUE_INT;
}
- (int) intForKey:(id)key{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(intValue)]) {
        return [object intValue];
    }
    return TG_NULL_VALUE_INT;
}
- (float) floatValueForKey:(id)key{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    }
    return TG_NULL_VALUE_FLOAT;
}
- (double) doubleValueKey:(id)key{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [object floatValue];
    }
    return TG_NULL_VALUE_FLOAT;
}
- (BOOL) boolValueForKey:(id)key{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [object boolValue];
    }
    return TG_NULL_VALUE_BOOL;
}

@end
