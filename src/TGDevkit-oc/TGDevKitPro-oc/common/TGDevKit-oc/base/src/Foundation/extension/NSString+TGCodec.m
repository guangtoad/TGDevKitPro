//
//  NSString+TGCodec.m
//  TGFoundation
//
//  Created by toad on 2022/07/19.
//

#import "NSString+TGCodec.h"

@implementation NSString (TGCodec)
#pragma mark - BASE64
/// BASE64编码
- (NSString *) tg_base64Encode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
/// Base64解码
- (NSString *) tg_base64Decode{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data  encoding:NSUTF8StringEncoding];
}

#pragma mark - URLEncode
/// UrlEncode 编码
- (NSString * _Nonnull) tg_urlEncode{
    NSCharacterSet *chaSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:chaSet];
    return encodedString;
}
/// UrlDecode 解码
- (NSString * _Nonnull) tg_urlDecode{
    NSString *decodedString = [self stringByRemovingPercentEncoding];
    return decodedString;
}

#pragma mark - Localized

+ (NSString *) tg_localizedStringForKey:(NSString *)key bundle:(nullable NSBundle *)bundle{
    if (NULL != bundle) {
        return [bundle localizedStringForKey:key value:@"" table:nil];
    }
    else {
        return [NSBundle.mainBundle localizedStringForKey:key value:@"" table:nil];
    }
}
+ (NSString *) tg_localizedStringForKey:(NSString *)key{
    return [[self class] tg_localizedStringForKey:key bundle:NULL];
}

@end

/// 正则
@implementation NSString(validate)

/// 邮箱验证 MODIFIED BY HELENSONG
/// @return 结果
- (BOOL) isValidateEmail{
    return [self regexByStr:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}
/// 匹配正则
/// @param regex 正则表达式
/// @return 匹配结果
- (BOOL) regexByStr:(NSString *)regex{
    if (self.length == 0) {
        return false;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
/// 普通车牌检查
/// @return 匹配结果
-(BOOL) isValidateNomalCar{
    return [self regexByStr:@"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5}$"];
}
/// 使馆车辆检查
/// @return 结果
-(BOOL) isValidateEmbassyCar{
    return [self regexByStr:@"^[使]{1}[0-9]{6}$"];
}
/// 军队车辆检查
/// @return 结果
-(BOOL) isValidateArmyCar{
    if ([self hasPrefix:@"WJ"] && self.length >= 8) {
        return true;
    }
    return [self regexByStr:@"^[京]{1}[vV]{1}[a-zA-Z_0-9]{5}$"] ||   [self regexByStr:@"^[北南广沈成兰济空ABCDJKLMNOPRSTVYGH甲乙丙己庚辛壬寅辰戌午未申]{1}[a-zA-Z]{1}[0-9]{5}$"];
}
/// 警车检查
/// @return 检查结果
-(BOOL) isValidatePoliceCar{
    if (self.length == 7 && [[self substringFromIndex:6] isEqualToString:@"警"]) {
        return YES;
    }

    return NO;
}
/// 车牌号校验
/// @return 检查结果
- (BOOL) isValidateCarNumber{
    return [self isValidateNomalCar] || [self isValidateEmbassyCar] || [self isValidateArmyCar] || [self isValidatePoliceCar];
}

@end


@implementation NSString(date)

- (NSDate * _Nullable) tg_dateWithFormatter:(NSString * _Nullable)formatterStr locale:(NSLocale *)locale timeZone:(NSTimeZone *)timeZone{
    if (self.length || NULL == formatterStr || formatterStr.length < 1) {
        return NULL;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:locale];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:formatterStr];
    return [formatter dateFromString:self];
}
- (NSDate * _Nullable) tg_dateWithFormatter:(NSString * _Nullable)formatterStr{
    return [self tg_dateWithFormatter:formatterStr locale:[NSLocale systemLocale] timeZone:[NSTimeZone systemTimeZone]];
}

@end
