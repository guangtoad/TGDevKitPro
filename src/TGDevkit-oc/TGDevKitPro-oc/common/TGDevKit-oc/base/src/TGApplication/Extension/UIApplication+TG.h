//
//  UIApplication+TG.h
//  TGObj
//
//  Created by toad on 15/9/21.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+TG.h"
#define itunes_lookup @"http://itunes.apple.com/lookup?id="


@interface UIApplication (TG)
- (NSDictionary *) infoDictionary;
@end
