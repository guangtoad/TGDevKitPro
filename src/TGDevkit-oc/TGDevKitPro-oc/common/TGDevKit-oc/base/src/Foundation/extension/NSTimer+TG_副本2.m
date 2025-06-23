//
//  NSTimer+TG.m
//  WeiShop
//
//  Created by toad on 16/5/31.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "NSTimer+TG.h"

@implementation NSTimer (TG)

- (void) pause{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}
- (void) resume{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}
- (void) resumeTimerAfterTimeInterval:(NSTimeInterval)interval{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
