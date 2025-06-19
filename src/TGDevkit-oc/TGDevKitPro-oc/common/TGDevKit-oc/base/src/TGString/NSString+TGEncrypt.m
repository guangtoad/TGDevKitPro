//
//  NSString+TG.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

//#import "NSString+TG.h"
#import "NSString+TGEncrypt.h"

#pragma mark - NSString + BASE64
@implementation NSString (BASE64)
- (NSString *) base64{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *) decBase64{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data  encoding:NSUTF8StringEncoding];
}
@end
#pragma mark - NSString + MD5
@implementation NSString (MD5)
/*
 @method    MD5Value
 @brief 取MD5值
 @discussion 取MD5值
 @result md5加密后的字符串
 */
- (NSString *) MD5_16Value{
    if(self == nil || [self length] == 0)
        return nil;
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    //    NSLog(@"CC_MD5_DIGEST_LENGTH:%d",CC_MD5_DIGEST_LENGTH);
    for(NSInteger count = 4; count < CC_MD5_DIGEST_LENGTH - 4; count++){
        //        NSLog(@"outputBuffer[%d]=%02x",count,outputBuffer[count]);
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    //    NSLog(@"str:(%@) MD5 to------->str:(%@)",self,outputString);
    return TGAutorelease(outputString);
}
- (NSString *) MD5Value{
    if(self == nil || [self length] == 0)
        return nil;
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    //    NSLog(@"CC_MD5_DIGEST_LENGTH:%d",CC_MD5_DIGEST_LENGTH);
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH - 0; count++){
        //        NSLog(@"outputBuffer[%d]=%02x",count,outputBuffer[count]);
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    //    NSLog(@"str:(%@) MD5 to------->str:(%@)",self,outputString);
    return TGAutorelease(outputString);
}
/*
 @method    MD5Value
 @brief 取MD5值
 @discussion 取MD5值
 @param str    需要加密的字符串
 @result md5加密后的字符串
 */
+ (NSString *)md5:(NSString *)str{
    return [str MD5Value];
}
@end
#pragma mark - NSString + SHA1
@implementation NSString (SHA1)
/*
 @method    SHA1Value
 @brief sha1加密
 @result sha1加密后的字符串
 */
- (NSString*) SHA1Value{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);

    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}
+ (NSString *) sha1:(NSString *)str{
    return [str SHA1Value];
}
@end
#pragma mark - NSString + Encrypt
@implementation NSString (TG_Encrypt)

- (NSString *) enctrptWithType:(NSStringEncryptType) type{
    switch (type) {
        case NSStringEncryptMd5:
            return [self MD5Value];
        case NSStringEncryptSha1:
            return [self SHA1Value];
        case NSStringEncryptMd5_16:
            return [self MD5_16Value];
        case NSStringEncryptNO:
        default:
            return self;
    }
}
+ (NSString *) encryptStr:(NSString *)str type:(NSStringEncryptType)type{
    return [str enctrptWithType:type];
}
+ (NSString *) encrypt:(NSStringEncryptType )type str:(NSString *)str valist:(va_list)args{
    NSString *encryptstr = @"";
    if (str) {
        encryptstr = [encryptstr stringByAppendingString:str];
        NSString *i = va_arg(args, NSString*);
        while(i) {
            encryptstr = [encryptstr stringByAppendingString:i];
            i = va_arg(args, NSString*);
        }
    }
    return [NSString encryptStr:encryptstr type:type];
}
/*
 @method    encrypt:items:
 @brief 多字符链接 加密
 @param str,... 遇加密字符串
 @param type,... 加密方式
 @result 加密后字符串
 */
+ (NSString *) encrypt:(NSStringEncryptType )type items:(NSString *)str, ...{
    va_list args;
    va_start(args,str);
    NSString *s = [NSString encrypt:type str:str valist:args];
    va_end(args);
    return s;
}
@end
