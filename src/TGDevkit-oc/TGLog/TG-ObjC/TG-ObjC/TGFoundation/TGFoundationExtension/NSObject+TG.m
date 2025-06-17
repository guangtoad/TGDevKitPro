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

/**
 NSObject Coding 扩展
 */
@implementation NSObject (TGCoding)

/**
 
 通过路径解码
 
 @param filePath 文件路径
 @return 实例
 */
+ (id) unarchiveObjectFromFilePath:(NSString *)filePath{
    if (!filePath || 0 == filePath.length) {
        return nil;
    }
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingUncached error:&error];
    if (!error) {
        return nil;
    }
    typeof([self class]) obj = nil;
    if (@available(iOS 11.0,*)){
        obj = [NSKeyedUnarchiver unarchivedObjectOfClass:[self class] fromData:data error:&error];
        if (!error) {
            return nil;
        }
    }    
    return obj;
}

/**
 编码并保存到指定路径
 
 @param filePath 路径s
 @return 是否成功
 */
- (BOOL) archivedToFilePath:(NSString *)filePath{
    if (!filePath || 0 == filePath.length) {
        return false;
    }
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:true error:&error];
    if (!error) {
        return false;
    }
    return [data writeToFile:filePath atomically:true];
}

@end
