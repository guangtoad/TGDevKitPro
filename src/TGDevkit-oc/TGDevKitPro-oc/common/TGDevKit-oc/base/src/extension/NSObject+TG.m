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

@implementation NSObject (TG_Instance)

/// 单例对象
+ (instancetype)shareInstance{
    // 获取当前对象的类
    Class selfClass = [self class];
    // 从类中获取对象
    id instance = objc_getAssociatedObject(selfClass, @"TG_shareObject");
    
    if (!instance) {
        @synchronized (self) {
            // 不存在，创建对象
            instance = [[self allocWithZone:NULL] init];
            // 给类绑定对象
            objc_setAssociatedObject(selfClass, @"shareObject", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return instance;
}

@end

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