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

@implementation NSString(validate)
/**
 邮箱验证 MODIFIED BY HELENSONG

 @return 结果
 */
- (BOOL) isValidateEmail
{
    return [self regexByStr:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}
/**
 匹配正则

 @param regex 正则表达式
 @return 匹配结果
 */
- (BOOL) regexByStr:(NSString *)regex
{
    if (self.length == 0) {
        return false;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
/**
 普通车牌检查

 @return 匹配结果
 */
-(BOOL) isValidateNomalCar{
    return [self regexByStr:@"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5}$"];
}

/**
 使馆车辆检查

 @return 结果
 */
-(BOOL) isValidateEmbassyCar{
    return [self regexByStr:@"^[使]{1}[0-9]{6}$"];
}

/**
 军队车辆检查

 @return 结果
 */
-(BOOL) isValidateArmyCar{
    if ([self hasPrefix:@"WJ"] && self.length >= 8) {
        return true;
    }
    return [self regexByStr:@"^[京]{1}[vV]{1}[a-zA-Z_0-9]{5}$"] ||   [self regexByStr:@"^[北南广沈成兰济空ABCDJKLMNOPRSTVYGH甲乙丙己庚辛壬寅辰戌午未申]{1}[a-zA-Z]{1}[0-9]{5}$"];
}

/**
 警车检查

 @return 结果
 */
-(BOOL) isValidatePoliceCar{
    if (self.length == 7 && [[self substringFromIndex:6] isEqualToString:@"警"]) {
        return YES;
    }

    return NO;
}

- (BOOL) isValidateCarNumber{
    return [self isValidateNomalCar] || [self isValidateEmbassyCar] || [self isValidateArmyCar] || [self isValidatePoliceCar];
}
@end

@implementation NSString(date)

- (NSDate *) dateWithFormatter:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    return [formatter dateFromString:self];
}

@end
