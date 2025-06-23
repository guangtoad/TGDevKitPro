//
//  NSDictionary+TG.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "NSDictionary+TG.h"


#define TG_NULL_VALUE_BOOL false
#define TG_NULL_VALUE_INT   -1
#define TG_NULL_VALUE_STR   @""
#define TG_NULL_VALUE_DOULE 0

@implementation NSDictionary (TG_Json)
- (NSString *) jsonStr{
    return @"";
}
@end

@implementation NSDictionary (TG)

- (id) objectForKey:(id)aKey ClassModel:(Class)obj_class{
    
    id obj = [self objectForKey:aKey];
    if (obj != nil) {
        
        
    }
    if ([[obj class] isSubclassOfClass:obj_class]) {
        ;
        ;
    }
    if (obj != nil &&  [[obj class] isSubclassOfClass:obj_class]) {
        return obj;
    }
    return nil;
}
- (NSInteger) integerForKey:(id)key{
    return 0;
}
- (int) intForKey:(id)key{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(intValue)]) {
        return [object intValue];
    }
    return TG_NULL_VALUE_DOULE;
}
- (NSString *) stringForKey:(id)key{
    return nil;
}
- (float) floatForKey:(id)key{
    return 0;
}
- (double) doubleForKey:(id)key{
    return 0;
}

//- (int) getIntValueForKey:(id)aKey{
//    id obj = nil;
//    if ((obj = [self objectForKey:aKey ClassModel:[NSDecimalNumber class]])){
//        return [obj intValue];
//    }
//    else if ((obj = [self objectForKey:aKey ClassModel:[NSString class]]) ) {
//        return [obj intValue];
//    }
//    else if (obj == [self objectForKey:aKey ClassModel:[NSNumber class]]){
//        return [obj intValue];
//    }
//    else if ((obj = [self objectForKey:aKey ClassModel:[NSValue class]])) {
//        int obj_value = DEFAULT_REQUEST_VALUE_INT;
//        [obj getValue:&obj_value];
//        return obj_value;
//    }
//    return DEFAULT_REQUEST_VALUE_INT;
//}
//- (NSString *) getStringValueForKey:(id)aKey{
//    id obj = nil;
//    if ((obj = [self objectForKey:aKey ClassModel:[NSString class]])) {
//        return obj;
//    }
//    return @"";
//}
//- (BOOL) getBoolValueForKey:(id)aKey{
//    id obj = nil;
//    if ((obj = [self objectForKey:aKey ClassModel:[NSString class]]) ) {
//        return [obj boolValue];
//    }
//    else if ((obj = [self objectForKey:aKey ClassModel:[NSValue class]])) {
//        BOOL obj_value = false;
//        [obj getValue:&obj_value];
//        return obj_value;
//    }
//    return DEFAULT_REQUEST_VALUE_BOOL;
//}
//- (NSDictionary *) getDictionaryValueForKey:(id)aKey{
//    id obj = [self objectForKey:aKey ClassModel:[NSDictionary class]];
//    if (obj != nil) {
//        return obj;
//    }
//    return TAutorelease([[NSDictionary alloc] init]);
//}
@end
