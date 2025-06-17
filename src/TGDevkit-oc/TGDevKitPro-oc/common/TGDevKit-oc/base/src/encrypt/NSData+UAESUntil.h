//
//  NSData+UAESUntil.h
//  UAESDK
//
//  Created by lvzhao on 2020/7/16.
//  Copyright © 2020 ZeroCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (UAESUntil)



/*!
 *  @method toString:
 *  @discussion  Data数据转化为string  <e0eb2194 05929ded 767c71c1 10d81993> 转化为 e0eb219405929ded767c71c110d81993
 *  @return e0eb219405929ded767c71c110d81993
 *
 */
- (NSString *)toString;



/**
 Nsdata  CRC 校验 ，返回data
 */
- (NSData *)crcData;
/**
 AES_GCM加密模式
 */
//- (NSData *)aes_gcmEncrypt;

/**
 sha256
 */

- (NSData*)sha2_256;

//加密
- (NSData *)AES128EncryptWithData:(NSData *)key iv:(NSData *)iv;

//解密data
- (NSData *)AES128DecryptWithData:(NSData *)key iv:(NSData *)iv;
//crc校验
- (NSString *)CRC16;
- (NSString *) toHexString;
@end

NS_ASSUME_NONNULL_END
