//
//  NSString+TGRegex.m
//  TG
//
//  Created by toad on 2017/7/8.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "NSString+TGRegex.h"
#import <CommonCrypto/CommonDigest.h>
//#import <GTMBase64.h>

@implementation NSString(NSString_Ext)

- (NSString *)MD5Hash
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];

    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (CC_LONG)[data length], result);

    return [NSString
            stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1],result[2], result[3],result[4], result[5],result[6], result[7],
            result[8], result[9],result[10], result[11],result[12], result[13],result[14], result[15]
            ];
}

+ (NSString *) getStringFromGBGBase64String:(NSString *)strSource
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strSource options:NSDataBase64DecodingIgnoreUnknownCharacters];

    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    return string;
}

- (NSString *) base64{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
- (NSString *) decBase64{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data  encoding:NSUTF8StringEncoding] ;
}

//+ (NSString *)getBase64String:(NSString *)strSource
//{
//    //    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//
//
//    NSData *dataT = [strSource dataUsingEncoding:NSUTF8StringEncoding];
//    return [GTMBase64 stringByEncodingData:dataT];
//}
@end


