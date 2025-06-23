//
//  TGObject.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TG.h"

NS_INLINE NSInteger intgetValueBy(id obj){
    if (nil == obj || ![obj respondsToSelector:@selector(integerValue)]) {
        return 0;
    }
    return [obj integerValue];
}

NS_INLINE NSInteger intgetValueByDefault(id obj,NSInteger defaultValue){
    if (nil == obj || ![obj respondsToSelector:@selector(integerValue)]) {
        return defaultValue;
    }
    return [obj integerValue];
}
NS_INLINE BOOL boolValueBy(id obj){
    if (nil == obj || ![obj respondsToSelector:@selector(boolValue)]) {
        return false;
    }
    return [obj boolValue];
}
NS_INLINE double doubleValueBy(id obj){
    if (nil == obj || ![obj respondsToSelector:@selector(doubleValue)]) {
        return 0.0;
    }
    return [obj doubleValue];
}
NS_INLINE float floatValueBy(id obj){
    if (nil == obj || ![obj respondsToSelector:@selector(floatValue)]) {
        return 0.0;
    }
    return [obj floatValue];
}
NS_INLINE NSString *stringValueByObjDef(id obj,NSString *defValue){
    if (nil == obj) {
        return defValue;
    }
    else if ([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    else if ([obj respondsToSelector:@selector(stringValue)]){
        [obj string];
    }
    else {
        return defValue;
    }
    return defValue;
}
NS_INLINE NSString *stringValueByObj(id obj){

    if (nil == obj) {
        return @"";
    }
    else if ([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    else if ([obj respondsToSelector:@selector(stringValue)]){
        return [obj stringValue];
    }
    else if ([obj respondsToSelector:@selector(string)]){
        [obj string];
    }
    else {
        return @"";
    }
    return @"";
}
NS_INLINE NSArray *arrayValueByObj(id obj){
    if (obj == nil) {
        return [[NSArray  alloc] init] ;
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        return obj;
    }
    else {
        return [[NSArray alloc] initWithObjects:obj, nil];
    }
    return nil;
}
NS_INLINE NSDictionary *dictValueByObj(id obj){
    if (obj == nil) {
        return [[NSDictionary alloc] init] ;
    }
    else if ([obj isKindOfClass:[NSDictionary class]]){
        return obj;
    }
    return nil;
}

@interface TGObject : NSObject

- (instancetype) initWithDictionary:(NSDictionary *)dic;
+ (NSString *) typeWithConvertFromObjc_property_t:(objc_property_t)property;

@end
