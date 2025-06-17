//
//  TGUility.m
//  TG-ObjC
//
//  Created by toad on 2019/5/27.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGUtility.h"

/**
 工具类
 */
@implementation TGUtility

/**
 创建UUID

 @return UUID
 */
+ (NSString *) createUUID{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    CFRelease(uuidObject);
    return uuid;
}

@end
