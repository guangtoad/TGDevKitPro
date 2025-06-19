//
//  NSURL+TG.m
//  WeiShop
//
//  Created by toad on 16/6/3.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "NSURL+TG.h"

@implementation NSURL (TG)

+ (NSURL *) iCloudUrlWithFileName:(NSString *)fileName{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    return url != nil?[NSURL URLWithString:fileName relativeToURL:url]:nil;
}

@end
