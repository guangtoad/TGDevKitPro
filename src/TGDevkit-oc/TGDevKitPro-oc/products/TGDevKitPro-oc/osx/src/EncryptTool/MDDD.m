//
//  MDDD.m
//  EncryptTool
//
//  Created by home on 2018-07-26.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "MDDD.h"
#import <CommonCrypto/CommonDigest.h>
//#define CC_MD5_DIGEST_LENGTH 16
@implementation NSString (e)
- (NSString *)md5{
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}
- (NSString *) md516{
    NSString *md5Str = [self md5];

    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
- (NSString *)md5Lowercase{
    return [[self md5] lowercaseString];
}
- (NSString *)md5Uppercase{
    return [[self md5] uppercaseString];
}
- (NSString *)md516Lowercase{
    return [[self md516] lowercaseString];
}
- (NSString *)md516Uppercase{
    return [[self md516] uppercaseString];
}
@end
@implementation MDDD
#pragma mark - MD5加密 16位 大写
+ (NSString *)MD5ForUpper16Bate:(NSString *)str{

    NSString *md5Str = [self MD5ForUpper32Bate:str];

    NSString *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
#pragma mark - MD5加密 32位 大写
+ (NSString *)MD5ForUpper32Bate:(NSString *)str{

    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }

    return digest;
}

@end
