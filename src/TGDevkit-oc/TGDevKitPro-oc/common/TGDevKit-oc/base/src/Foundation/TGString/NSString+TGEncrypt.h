//
//  NSString+TG.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TG.h"
#import <CommonCrypto/CommonDigest.h>
#pragma mark - NSString + BASE64

@interface NSString (BASE64)

/**
 base64加密

 @return 加密后
 */
- (NSString *) base64;

@end

#pragma mark - NSString + MD5
@interface NSString (MD5)
/*
 @method    MD5Value
 @brief 取MD5值
 @discussion 取MD5值
 @result md5加密后的字符串
 */
- (NSString *) MD5Value;
/*
 @method    MD5Value
 @brief 取MD5值
 @discussion 取MD5值
 @param str    需要加密的字符串
 @result md5加密后的字符串
 */
+ (NSString *)md5:(NSString *)str;
@end
#pragma mark - NSString + SHA1
@interface NSString (SHA1)

- (NSString*) SHA1Value;
+ (NSString *) sha1:(NSString *)str;
@end
typedef NS_ENUM(NSInteger, NSStringEncryptType){
    NSStringEncryptNO = 0,
    NSStringEncryptMd5 = 1,
    NSStringEncryptSha1 = 2,
    NSStringEncryptMd5_16 = 3,
};
#pragma mark - NSString + Encrypt
@interface NSString (TG_Encrypt)
/*
 @method    enctrptWithType:
 @brief 按类型加密
 @result 加密后字符串
 */
- (NSString *) enctrptWithType:(NSStringEncryptType) type;
+ (NSString *) encryptStr:(NSString *)str type:(NSStringEncryptType)type;
/*
 @method    encrypt:items:
 @brief 多字符链接 加密
 @param str,... 遇加密字符串
 @param type,... 加密方式
 @result 加密后字符串
 */
+ (NSString *) encrypt:(NSStringEncryptType )type items:(NSString *)str, ...;
@end
