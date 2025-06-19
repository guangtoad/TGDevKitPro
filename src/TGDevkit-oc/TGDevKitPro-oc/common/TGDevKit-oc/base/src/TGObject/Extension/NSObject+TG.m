//
//  NSObjet+TG.m
//  TGObj
//
//  Created by toad on 15/9/21.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "NSObject+TG.h"

@implementation NSObject (TG_runtime)

+ (NSString *) typeWithConvertFromObjc_property_t:(objc_property_t)property{
    @synchronized(self){
        char * type = property_copyAttributeValue(property, "T");
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
+ (void) registerKVO{
    
}

@end

@implementation NSObject (TG_Dictionary)

- (NSDictionary *) dictionaryValue{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    return dic;
}

@end

@implementation NSObject (TG_Sqlite)

@end

