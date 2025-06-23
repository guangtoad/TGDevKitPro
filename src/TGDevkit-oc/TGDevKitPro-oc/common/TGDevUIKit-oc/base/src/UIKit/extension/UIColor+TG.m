//
//  UIColor+TG.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "UIColor+TG.h"

@implementation UIColor (TG)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha{
    //去掉前后空格换行符
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned long r, g, b;
    r = strtoul([rString UTF8String], 0, 16);
    g = strtoul([gString UTF8String], 0, 16);
    b = strtoul([bString UTF8String], 0, 16);
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert{
    return [self colorWithHexString:stringToConvert alpha:1.0];
}

@end
