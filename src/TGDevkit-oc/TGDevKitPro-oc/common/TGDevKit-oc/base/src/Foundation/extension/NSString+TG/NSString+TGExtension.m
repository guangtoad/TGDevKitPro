//
//  NSString+TGExtension.m
//  TG
//
//  Created by toad on 2018/4/25.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "NSString+TGExtension.h"

@implementation NSString (TGExtension)

- (NSDate *) dateWithFormatter:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    return [formatter dateFromString:self];
}

/**
 @brief 两头去空格

 @return str
 */
- (NSString *) trim{
    return [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 @brief 两头去

 @param str 去掉的
 @return str
 */
- (NSString *) trimByStr:(NSString *)str{
    return [[self description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:str]];
}

@end
