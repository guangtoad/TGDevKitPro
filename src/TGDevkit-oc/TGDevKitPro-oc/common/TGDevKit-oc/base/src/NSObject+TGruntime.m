//
//  NSObject+RunTime.m
//  ObjCDome
//
//  Created by home on 2017/11/23.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "NSObject+TGruntime.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define PROPERTYP_PREIFX "_"
@implementation NSObject (TGRunTime)

- (Method) getInstanceMethod:(SEL)sel{
    Method method = class_getInstanceMethod([self class], sel);
    if (method != nil) {
        return method;
    }
    return nil;
}
- (char *) getTypeInstanceMethod:(SEL)sel{
    Method method = [self getInstanceMethod:sel];
    return method_copyReturnType(method);
}

- (Ivar) getInstanceVariable:(NSString *)name{
    const char *ivarName = [name UTF8String];
    Ivar ivar = class_getInstanceVariable([self class], ivarName);
    if (ivar != nil) {
        return ivar;
    }
    else {
        char* c = (char*)malloc(strlen(PROPERTYP_PREIFX) + strlen(ivarName) + 1);
        strcpy(c, PROPERTYP_PREIFX);
        strcat(c, ivarName);
        ivar = class_getInstanceVariable([self class], c);
        free(c);
        if (ivar != nil) {
            return ivar;
        }
        else {
        }
    }
    return nil;
}
- (id) getInstanceName:(NSString *)key{
    Ivar ivar = [self getInstanceVariable:key];
    if (ivar != nil) {
        return object_getIvar(self, ivar);
    }
    return nil;
}

- (id) getValueName:(NSString *)name{
    const char *n = [name UTF8String];
    id obj = nil;
    SEL sel = sel_getUid(n);
    Method method = class_getInstanceMethod([self class], sel);
    if (method != nil) {
        char *c = method_copyReturnType(method);
        NSLog(@"ReturnType:%s",c);
        switch (c[0]) {
                //long
            case 'i':{
                break;
            }
            case 'c':{
                break;
            }
            case '{':{
                if (strlen(c) ) {
                    
                }
                break;
            }
            case '@':{
                break;
            }
            default:{
                break;
            }
        }
        free(c);
    }
    printf("\n\n");
    return obj;
}

+ (NSArray *)getAllIvar{
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const  char *keyChar = ivar_getName(ivar);
        const  char *typeChar = ivar_getTypeEncoding(ivar);
        NSString *keyStr = [NSString stringWithCString:keyChar encoding:NSUTF8StringEncoding];
        NSString *typeStr = [NSString stringWithCString:typeChar encoding:NSUTF8StringEncoding];
        
        @try {
            [array addObject:[NSString stringWithFormat:@"%@:%@",keyStr,typeStr]];
        }
        @catch (NSException *exception) {}
    }
    return [array copy];
}
- (NSArray *)getAllIvar{
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const  char *keyChar = ivar_getName(ivar);
        NSString *keyStr = [NSString stringWithCString:keyChar encoding:NSUTF8StringEncoding];
        @try {
            id valueStr = [self valueForKey:keyStr];
            NSDictionary *dic = nil;
            if (valueStr) {
                dic = @{keyStr : valueStr};
            } else {
                dic = @{keyStr : @"值为nil"};
            }
            [array addObject:dic];
        }
        @catch (NSException *exception) {}
    }
    return [array copy];;
}

@end
