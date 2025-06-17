//
//  NSString+TGRegex.h
//  LancareAPP
//
//  Created by toad on 2017/7/8.
//  Copyright © 2017年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(NSString_Ext)

// md5 加密
- (NSString *)MD5Hash;

+ (NSString *)getStringFromGBGBase64String:(NSString *)strSource;

/**
 base64加密

 @return 加密后
 */
- (NSString *) base64;

/**
 base64解密

 @return 解密后
 */
- (NSString *) decBase64;
//+ (NSString *)getBase64String:(NSString *)strSource;
@end

