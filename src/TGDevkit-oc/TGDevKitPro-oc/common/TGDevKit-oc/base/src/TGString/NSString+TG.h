//
//  NSString+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import "TGMacros.h"

#pragma mark - DateFrmatType
typedef NS_ENUM(NSInteger,StringFrmatType){
    StringFrmatTypeyyyyMMdd,
    StringFrmatTypeYYYYMMddHHmm,
    StringFrmatTypeYYYYMMddHHmmss,
    StringFrmatTypeYYYYMMddhhmmssSSS,
};

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

#pragma mark - NSString + Macros
#define MD5(__str__)    [NSString encryptStr:__str__ type:NSStringEncryptMd5]
#define MD5VAL(...)     [NSString encrypt:NSStringEncryptMd5 items:__VA_ARGS__]

#define MD5_16(__str__)    [NSString encryptStr:__str__ type:NSStringEncryptMd5_16]
#define MD5_16VAL(...)     [NSString encrypt:NSStringEncryptMd5_16 items:__VA_ARGS__]
#define SHA1(__str__)    [NSString encryptStr:__str__ type:NSStringEncryptSha1]
#define SHA1VAL(...)     [NSString encrypt:NSStringEncryptSha1 items:__VA_ARGS__]


@interface  NSString (URL)
- (NSString *) addURLParameter:(NSDictionary *)parmaeter;
@end

@interface NSString (Date)

- (NSDate *) dateFormat:(NSString *)dateFormat;

+ (NSString *) stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval Format:(NSString *)format;

+ (NSString *) yyyymmddHHMMSSWith:(NSTimeInterval)timeInterval;
+ (NSString *) yyyymmddHHMMWith:(NSTimeInterval)timeInterval;

@end

@interface NSString (Validate)
+ (NSString *)intToBinary:(int)intValue;
//邮箱验证
- (BOOL) validateEmail;
//手机号码验证
- (BOOL) validateMobile;
//车牌号验证
- (BOOL) validateCarNo;
//车型
- (BOOL) validateCarType;
//用户名
- (BOOL) validateUserName;
//密码
- (BOOL) validatePassword;
//昵称
- (BOOL) validateNickname;
//身份证号
- (BOOL) validateIdentityCard;
//QQ号码验证
- (BOOL) validateQQ;
//判断是否为整形：
- (BOOL)isPureInt;
//判断是否为浮点形：
- (BOOL)isPureFloat;
//url
- (BOOL) validateUrl;
@end

@interface NSString (Value)

- (NSNumber *) numberValue;

@end

@interface NSString (jsonValue)

- (id) jsonValueUsingEncoding:(NSStringEncoding)encoding;
- (id) jsonValue;
- (NSDictionary *) jsonDictionaryValue;
- (NSDictionary *) jsonArrayValue;

@end

@interface NSString (TG)

@end


