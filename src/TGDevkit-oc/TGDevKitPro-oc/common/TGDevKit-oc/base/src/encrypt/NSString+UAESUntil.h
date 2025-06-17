//
//  NSString+UAESUntil.h
//  UAESDK
//
//  Created by lvzhao on 2020/7/16.
//  Copyright © 2020 ZeroCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (UAESUntil)
 /**
  十六进制的字符串转换为 bytez组
  字符串"FE0101112" -> Byte byte[] = {0xFE, 0x01, 0x01, 0x11, 0x12,}
  */
- (NSData *)dataBytez;

 /**
  十六进制的字符串string转化为Data
  "FE0101112" = <fe0101112>
  */
- (NSData *)dataEncoding;
 /**
  十进制转换十六进制
  */
- (NSString *)toOxDecimal;

/**
 十六进制转换十进制
 */
- (NSInteger)toDecimal;

- (NSString *)stringByReplaceUnicode;



@end

NS_ASSUME_NONNULL_END
