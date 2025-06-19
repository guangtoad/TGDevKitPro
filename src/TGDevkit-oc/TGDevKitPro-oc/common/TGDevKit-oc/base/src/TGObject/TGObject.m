//
//  TGObject.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "TGObject.h"

@implementation TGObject

+ (NSString *) typeWithConvertFromObjc_property_t:(objc_property_t)property{
    @synchronized(self){
        char * type = property_copyAttributeValue(property, "T");
//        NSString *ccls = [NSString stringWithUTF8String:type];
        switch(type[0]) {
            case 'f' : return @"float";
            case 'd' : return @"double";
            case 'c' : return @"char";
            case 's' : return @"short";
            case 'i' : return @"int";
            case 'l' : return @"long";
            case 'q' : return @"long";
            case '*' : return @"char";
            default  : return @"unKnow";
            case '@' : {
                NSString *cls = [NSString stringWithUTF8String:type];
                cls = [cls stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                cls = [cls stringByReplacingOccurrencesOfString:@"@" withString:@""];
                cls = [cls stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                if ([cls isEqualToString:@""]) {
                    return @"id";
                }
                return cls;
            };
        }
    }
}
- (instancetype) initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        
    }
    return self;
}
- (NSDictionary *) dictionaryValue{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);//获得属性列表
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        id value = [self valueForKey:propName];//kvc读值
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
//            value = [self getObjectInternal:value];//自定义处理数组，字典，其他类
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}
+ (NSDictionary *)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        id value = [obj valueForKey:propName];//kvc读值
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];//自定义处理数组，字典，其他类
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}
+ (id)getObjectInternal:(id)obj
{
    
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}
@end
