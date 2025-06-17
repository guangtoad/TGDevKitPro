//
//  TGUility.h
//  TG-ObjC
//
//  Created by toad on 2019/5/27.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for TGKitExtension.
FOUNDATION_EXPORT double TGUtilityVersionNumber;

//! Project version string for TGKitExtension.
FOUNDATION_EXPORT const unsigned char TGUtilityExtensionVersionString[];


/**
 工具类
 */
@interface TGUtility : NSObject

/**
 创建UUID
 
 @return UUID
 */
+ (NSString *) createUUID;
@end


