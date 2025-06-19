//
//  UIApplication+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGMacros.h"
@interface UIApplication (TG)

+ (void) setAppId:(NSString *)appid;
+ (BOOL) versionCheck;

@end
