//
//  NSString+TG.m
//  TG-ObjC
//
//  Created by toad on 2019/3/30.
//  Copyright © 2019 toad. All rights reserved.
//

#import "NSString+TG.h"

@implementation NSString (TG)

- (NSString *) trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+ (BOOL) IsNullOrEmpty:(NSString *)str{
    return nil == str || str.length < 1;
}
+ (BOOL) IsNullOrWhiteSpace:(NSString *)str{
    return [self IsNullOrEmpty:str] || [str trim].length < 1;
}

- (NSString *) urlEncode{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

}
- (NSString *) urlDecode{
    
    return [self stringByRemovingPercentEncoding];
}
@end
