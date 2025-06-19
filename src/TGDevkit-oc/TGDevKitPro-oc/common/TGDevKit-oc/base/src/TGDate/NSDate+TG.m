//
//  NSDate+TG.m
//  WeiShop
//
//  Created by toad on 16/5/31.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "NSDate+TG.h"

@implementation NSDate (TG)

+ (NSDateFormatter *)dateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter stringFromDate:[self dateWithTimeIntervalSinceNow:0]];
    return dateFormatter;
}

@end
