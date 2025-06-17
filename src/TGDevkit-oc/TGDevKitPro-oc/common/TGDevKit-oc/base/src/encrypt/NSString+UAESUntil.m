//
//  NSString+UAESUntil.m
//  UAESDK
//
//  Created by lvzhao on 2020/7/16.
//  Copyright © 2020 ZeroCloud. All rights reserved.
//

#import "NSString+UAESUntil.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+UAESUntil.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (UAESUntil)

/**
 十六进制的字符串转换为 bytez组
 字符串"FE0101112" -> Byte byte[] = {0xFE, 0x01, 0x01, 0x11, 0x12,}
 */
- (NSData *)dataBytez{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        
        [data appendBytes:&intValue length:1];
    }
    return data;
}

/**
 十六进制的f字符串string转化为Data
 */
- (NSData *)dataEncoding{
    [self lowercaseString];
    NSMutableData *data= [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    NSUInteger length = self.length;
    while (i < length-1) {
        char c = [self characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [self characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

/**
 十进制转换十六进制
 @return 十六进制数
 */
- (NSString *)toOxDecimal {
    
    NSInteger decimal = [self integerValue];
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}

/**
 十六进制转换十进制
 */

- (NSInteger)toDecimal{
    UInt64 mac1 =  strtoul([self UTF8String], 0, 16);
    return mac1;
}



- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}




@end
