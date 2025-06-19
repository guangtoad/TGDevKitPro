//
//  NSTimer+TG.h
//  WeiShop
//
//  Created by toad on 16/5/31.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (TG)

- (void) pause;
- (void) resume;
- (void) resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
