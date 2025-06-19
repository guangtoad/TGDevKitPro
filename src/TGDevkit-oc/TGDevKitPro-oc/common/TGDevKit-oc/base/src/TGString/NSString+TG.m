//
//  NSString+TG.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "NSString+TG.h"


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
@implementation NSString (phonetic)
+ (NSString *) transformToPinyin:(NSString*)sourceString {
    return [sourceString transformToPinyin];
}
- (NSString *)transformToPinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    return mutableString;
}
@end

@implementation NSString (URL)
- (NSString *) addURLParameter:(NSDictionary *)parmaeter{
    NSString *URLStr = self;
    if (parmaeter != nil) {
        int i = 0;
        for (NSString *item in [parmaeter allKeys]) {
            id obj = [parmaeter objectForKey:item];
            if ([[obj class] isSubclassOfClass:[NSString class]]) {
                NSString *appendString = [NSString stringWithFormat:(i++ == 0?@"?%@=%@":@"&%@=%@"),item,obj];
                URLStr = [URLStr stringByAppendingString:appendString];
            }
        }
    }
    return URLStr;
}
@end

@implementation NSString (Date)

- (NSDate *) dateFormat:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    return TGAutorelease([formatter dateFromString:self]);
}

+ (NSString *) stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval Format:(NSString *)format{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    return [dateformatter stringFromDate:date];
}

+ (NSString *) yyyymmddHHMMSSWith:(NSTimeInterval)timeInterval{
    return [self stringWithTimeIntervalSince1970:timeInterval Format:@"yyyymmddHHMMSS"];
}
+ (NSString *) yyyymmddHHMMWith:(NSTimeInterval)timeInterval{
    return [self stringWithTimeIntervalSince1970:timeInterval Format:@"yyyymmddHHMMWith"];
}

@end

@implementation NSString (Validate)

//判断是否为整形：
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点形：
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)intToBinary:(int)intValue{
    int totalBits = (intValue > 1?floor(sqrt(intValue)) + 1:1); // Total bits
    int binaryDigit = totalBits; // Which digit are we processing   // C array - storage plus one for null
    char ndigit[totalBits + 1];
    while (binaryDigit-- > 0)
    {
        // Set digit in array based on rightmost bit
        ndigit[binaryDigit] = (intValue & 1) ? '1' : '0';
        // Shift incoming value one to right
        intValue >>= 1;  }   // Append null
    ndigit[totalBits] = 0;
    // Return the binary string
    return [NSString stringWithUTF8String:ndigit];
}
//邮箱验证
- (BOOL) validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//手机号码验证
- (BOOL) validateMobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//QQ号码验证
- (BOOL) validateQQ{
    
    NSString *phoneRegex = @"^([0-9]{5,18})$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//车牌号验证
- (BOOL) validateCarNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}
//车型
- (BOOL) validateCarType{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}
//用户名
- (BOOL) validateUserName{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}
//密码
- (BOOL) validatePassword{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
//昵称
- (BOOL) validateNickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}
//身份证号
- (BOOL) validateIdentityCard{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
//url
- (BOOL) validateUrl{
    NSString *      regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
@end

@implementation NSString (Value)

- (NSNumber *) numberValue{
    return [NSNumber numberWithFloat:[self doubleValue]];
}

@end

@implementation NSString (jsonValue)

- (id) jsonValueUsingEncoding:(NSStringEncoding)encoding{
    NSData *data = [self dataUsingEncoding:encoding];
    NSError *jsonError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    if (jsonError) {
        TGLOGERROR(@"json Error:%@",jsonError);
        return [[NSObject alloc] init];
    }
    return jsonObject;
}
- (id) jsonValue{
    return [self jsonValueUsingEncoding:NSUTF8StringEncoding];
}
- (NSDictionary *) jsonDictionaryValue{
    id jsonObj = [self jsonValue];
    return [jsonObj isKindOfClass:[NSDictionary class]] ? jsonObj:[[NSDictionary alloc] initWithObjectsAndKeys:jsonObj,@"data", nil];
}
- (NSDictionary *) jsonArrayValue{
    id jsonObj = [self jsonValue];
    return [jsonObj isKindOfClass:[NSArray class]] ? jsonObj:[[NSArray alloc] initWithObjects:jsonObj, nil];
    return nil;
}

@end

@implementation NSString (TG)

@end



