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

/**
 通过key 与类型 获取 obj

 @param aKey key
 @param obj_class 类型
 @return 返回指定类型子类或空
 */
- (id _Nullable) objectForKey:(id _Nonnull)aKey ClassModel:(Class _Nonnull)obj_class{
    id obj = [self objectForKey:aKey];
    if (obj != nil) {
        
    }
    if (obj != nil &&  [[obj class] isSubclassOfClass:obj_class]) {
        return obj;
    }
    return nil;
}

- (NSInteger) integerForKey:(id _Nonnull)key defValue:(NSInteger)def{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(integerValue)]) {
        return [object integerValue];
    }
    return def;
}
- (NSInteger) integerForKey:(id _Nonnull)key{
    return [self integerForKey:key defValue:0];
}

/**
 通过key获取int 值

 @param key key
 @param def 默认返回数字
 @return int 数字
 */
- (int) intForKey:(id _Nonnull)key defValue:(int)def{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(intValue)]) {
        return [object intValue];
    }
    return def;
}

/**
 通过key获取int 值

 @param key key
 @return int 默认返回0
 */
- (int) intForKey:(id _Nonnull)key{
    return [self intForKey:key defValue:0];
}

- (NSString * _Nullable) stringForKey:(id _Nonnull)key defValue:(NSString *)defValue{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    if ([object respondsToSelector:@selector(stringValue)]) {
        return [object stringValue];
    }
    return defValue;
}
- (NSString * _Nullable) stringForKey:(id _Nonnull)key{
    return [self stringForKey:key defValue:@""];
}

- (float) floatForKey:(id _Nonnull)key defValue:(float)defValue{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    }
    return defValue;
}
- (float) floatForKey:(id _Nonnull)key{
    return [self floatForKey:key defValue:0];
}

- (double) doubleForKey:(id _Nonnull)key defValue:(double)defValue{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [object doubleValue];
    }
    return defValue;
}
- (double) doubleForKey:(id _Nonnull)key{
    return [self doubleForKey:key defValue:0];
}


- (BOOL) booleForKey:(id _Nonnull)key defValue:(BOOL)defValue{
    id object = [self objectForKey:key];
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [object boolValue];
    }
    return defValue;
}
- (BOOL) booleForKey:(id _Nonnull)key{
    return [self booleForKey:key];
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
