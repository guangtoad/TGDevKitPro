//
//  NSObject+TG.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "NSObject+TG.h"

@implementation NSObject (NSDictionary)

- (NSString *) toString{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#if __openRunTime
+ (NSString *) attributeNameWith:(objc_property_t)property{
    char * type = property_copyAttributeValue(property, "T");
    switch(type[0]) {
        case 'f' : return @"float"; //float
        case 'd' : return @"double"; //double
        case 'c' : return @"char"; // char
        case 'C' : return @"unsigned char";
        case 's' : return @"short";//short
        case 'S' : return @"unsigned short";//short
        case 'i' : return @"int";   // int
        case 'I' : return @"unsigned";//
        case 'q' : return @"long";
        case 'Q' : return @"unsigned long";
        case 'l' : return @"long long";   // long
        case '*' : return @"void";   // char *
        case '@' : {
            NSString *cls = [NSString stringWithUTF8String:type];
            cls = [cls stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            cls = [cls stringByReplacingOccurrencesOfString:@"@" withString:@""];
            cls = [cls stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            if ([cls isEqualToString:@""]) {
                return @"id";
            }
            return cls;
        }
        default:{
            return @"(null)";
        }
            break;
    }
    return @"";
}
- (id)valueForDbObjc_property_t:(objc_property_t)property dbValue:(id)dbValue _id:(NSInteger)_id{
    @synchronized(self){
        char * type = property_copyAttributeValue(property, "T");
        
        //        if (!dbValue) {
        //            return nil;
        //        }
        NSLog(@"type:%s",type);
        switch(type[0]) {
            case 'f' : //float
            {
                return [NSNumber numberWithDouble:[dbValue floatValue]];
            }
                break;
            case 'd' : //double
            {
                return [NSNumber numberWithDouble:[dbValue doubleValue]];
            }
                break;
                
            case 'c':   // char
            {
                return [NSNumber numberWithDouble:[dbValue charValue]];
            }
                break;
            case 's' : //short
            {
                return [NSNumber numberWithDouble:[dbValue shortValue]];
            }
                break;
            case 'i':   // int
            {
                return [NSNumber numberWithDouble:[dbValue longValue]];
            }
                break;
            case 'l':   // long
            {
                return [NSNumber numberWithDouble:[dbValue longValue]];
            }
                break;
                
            case '*':   // char *
                break;
                
            case '@' : //ObjC object
                //Handle different clases in here
            {
                NSString *cls = [NSString stringWithUTF8String:type];
                cls = [cls stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                cls = [cls stringByReplacingOccurrencesOfString:@"@" withString:@""];
                cls = [cls stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                Class class = NSClassFromString(cls);
                if ([class isSubclassOfClass:[NSString class]]) {
                    NSString *retStr = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", dbValue]];
                    return retStr;
                }
                else if ([class isSubclassOfClass:[NSNumber class]]) {
                    return [NSNumber numberWithDouble:[dbValue doubleValue]];
                }
                else if ([class isSubclassOfClass:[NSDate class]]){
                    
                }
                else if ([class isSubclassOfClass:[NSObject class]]) {
                    return [dbValue toDictionary];
                }
            }
                break;
        }
        
        return dbValue;
    }
}
- (NSDictionary *) toDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
#if __openRunTime
    NSObject *obj = self;
    Class cls = [obj class];
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    if (!properties) {
        while (1) {
            cls = [cls superclass];
            properties = class_copyPropertyList(cls, &count);
            if (properties) {
                break;
            }
        }
    }
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property_getAttributes(property) = %s",
              property_getAttributes(property));
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id objValue = [obj valueForKey:key];
        
        id value = [self valueForDbObjc_property_t:property dbValue:objValue _id:-1];
        
        if (value && (NSNull *)value != [NSNull null]) {
            [dic setObject:value forKey:key];
        }
    }
#endif
    NSLog(@"dic = :%@",dic);
    return dic;
}
+ (NSDictionary *) toDictionary{
    Class cls = [self class];
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    if (!properties) {
        while (1) {
            cls = [cls superclass];
            properties = class_copyPropertyList(cls, &count);
            if (properties) {
                break;
            }
        }
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id value =  [self attributeNameWith:property];
        if (value && (NSNull *)value != [NSNull null]) {
            [dic setObject:value forKey:key];
        }
    }
    return dic;
}

- (id) initFromDictionary:(NSDictionary *)dictionary{
    if (self = [self init]) {
        
        Class cls = [self class];
        unsigned int count;
        
        objc_property_t *properties = class_copyPropertyList(cls, &count);
    }
    return self;
}

#endif

@end

@implementation NSObject (UIKeyboardNotification)

- (void) keyboardWillShowNotification:(NSNotification *)note {
}
- (void) keyboardWillHideNotification:(NSNotification *)note {
}

- (void) addKeyboardResponderObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void) removeKeyboardResponderObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

@end

@implementation NSObject (TG)

+ (id) sharedInstance{
    @synchronized (self) {
        static id instance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if(instance == nil){
                instance = [[self alloc] init];
            }
        });
        return instance;
    }
}

@end
