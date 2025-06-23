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

@end
