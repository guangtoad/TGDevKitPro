//
//  NSData+UAESUntil.m
//  UAESDK
//
//  Created by lvzhao on 2020/7/16.
//  Copyright © 2020 ZeroCloud. All rights reserved.
//

#import "NSData+UAESUntil.h"
#import <CommonCrypto/CommonCryptor.h>
//#import "IAGAesGcm.h"
//#import <UIKit/UIKit.h>
#import "NSString+UAESUntil.h"
#import <CommonCrypto/CommonDigest.h>
//#import "IAGCipheredData.h"



//static const unsigned short CRCTable[] =
//{       /* CRC tab */
//    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
//    0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
//    0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
//    0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
//    0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
//    0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
//    0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
//    0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
//    0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
//    0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
//    0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
//    0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
//    0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
//    0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
//    0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
//    0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
//    0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
//    0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
//    0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
//    0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
//    0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
//    0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
//    0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
//    0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
//    0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
//    0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
//    0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
//    0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
//    0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
//    0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
//    0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
//    0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
//};

typedef unsigned short  crc;
#define CRC_NAME            "CRC-16"
#define POLYNOMIAL            0x8005
#define INITIAL_REMAINDER    0x0000
#define FINAL_XOR_VALUE        0x0000
#define REFLECT_DATA            1
#define REFLECT_REMAINDER        1
#define CHECK_VALUE            0xBB3D
/*
 * Derive parameters from the standard-specific parameters in crc.h.
 */
#define WIDTH    (8 * sizeof(crc))
#define TOPBIT   (1 << (WIDTH - 1))

#if (REFLECT_DATA == 1)
#undef  REFLECT_DATA
#define REFLECT_DATA(X)            ((unsigned char) reflect((X), 8))
#else
#undef  REFLECT_DATA
#define REFLECT_DATA(X)            (X)
#endif

#if (REFLECT_REMAINDER == 1)
#undef  REFLECT_REMAINDER
#define REFLECT_REMAINDER(X)    ((crc) reflect((X), WIDTH))
#else
#undef  REFLECT_REMAINDER
#define REFLECT_REMAINDER(X)    (X)
#endif





//加密用的key
NSString * k_AES_GCM_Key= @"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";

NSString * k_AES_GCM_IV= @"FFFFFFFFFFFFFFFFFFFFFFFF";

NSString * k_AES_GCM_AAD= @"FFFFFFFFFFFFFFFFFFFFFFFF";

CGFloat TagLenght = 32;

@implementation NSData (UAESUntil)
/*********************************************************************
 *
 * Function:    reflect()
 *
 * Description: Reorder the bits of a binary sequence, by reflecting
 *                them about the middle position.
 *
 * Notes:        No checking is done that nBits <= 32.
 *
 * Returns:        The reflection of the original data.
 *
 *********************************************************************/
static unsigned long
reflect(unsigned long data, unsigned char nBits)
{
    unsigned long  reflection = 0x00000000;
    unsigned char  bit;

    /*
     * Reflect the data about the center bit.
     */
    for (bit = 0; bit < nBits; ++bit)
    {
        /*
         * If the LSB bit is set, set the reflection of it.
         */
        if (data & 0x01)
        {
            reflection |= (1 << ((nBits - 1) - bit));
        }

        data = (data >> 1);
    }

    return (reflection);

}    /* reflect() */


/*********************************************************************
 *
 * Function:    crcSlow()
 *
 * Description: Compute the CRC of a given message.
 *
 * Notes:
 *
 * Returns:        The CRC of the message.
 *
 *********************************************************************/
crc
crcSlow(unsigned char const message[], int nBytes)
{
    crc            remainder = INITIAL_REMAINDER;
    int            byte;
    unsigned char  bit;


    /*
     * Perform modulo-2 division, a byte at a time.
     */
    for (byte = 0; byte < nBytes; ++byte)
    {
        /*
         * Bring the next byte into the remainder.
         */
        remainder ^= (REFLECT_DATA(message[byte]) << (WIDTH - 8));

        /*
         * Perform modulo-2 division, a bit at a time.
         */
        for (bit = 8; bit > 0; --bit)
        {
            /*
             * Try to divide the current data bit.
             */
            if (remainder & TOPBIT)
            {
                remainder = (remainder << 1) ^ POLYNOMIAL;
            }
            else
            {
                remainder = (remainder << 1);
            }
        }
    }

    /*
     * The final remainder is the CRC result.
     */
    return (REFLECT_REMAINDER(remainder) ^ FINAL_XOR_VALUE);

}   /* crcSlow() */


/**
 Nsdata  CRC 校验 ，返回data
 */
- (NSData *)crcData {
    NSMutableData *tempSendData = [NSMutableData dataWithData:self];
    crc cr = crcSlow(self.bytes, (int)self.length);
    Byte crcH = cr>>8;
    Byte chcC = cr;
    [tempSendData appendBytes:&crcH length:sizeof(crcH)];
    [tempSendData appendBytes:&chcC length:sizeof(chcC)];
    return tempSendData;
}


/**
    AES cbc 模式加密，
    @key 长度16字节，24字节，32字节
    @iv 16字节
 */
- (NSData *)AES_CBC_EncryptWith:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding ,
                                          keyPtr, kCCBlockSizeAES128,
                                          [iv UTF8String],
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


/**
    AES cbc 模式解密，
    @key 长度16字节，24字节，32字节
    @iv 16字节
 */
- (NSData *)AES_CBC_DecryptWith:(NSData *)key iv:(NSData *)iv
{
    NSData *retData = nil;
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes, key.length,
                                          iv.bytes,
                                          self.bytes, self.length,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        retData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return retData;
}

/**
 Data数据转化为string
 <e0eb2194 05929ded 767c71c1 10d81993> -> e0eb219405929ded767c71c110d81993
*/
- (NSString *)toString{
    Byte *bytes = (Byte *)[self bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[self length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    hexStr = [hexStr uppercaseString];
    return hexStr;
}

- (NSString *) toHexString{
    NSString *hexStr = [self toString];
    return hexStr.length > 0 ? [NSString stringWithFormat:@"0x%@",hexStr]:@"";
}
/**
 *  SHA256,结果为32个字节
 *
 *  @return sha256
 */
- (NSData*)sha2_256
{
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    (void) CC_SHA256( [self bytes], (CC_LONG)[self length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA256_DIGEST_LENGTH] );
}


/**
 加密data
 CCCrypt(kCCDecrypt,  //kCCDecrypt是解密，kCCEncrypt是加密
 kCCAlgorithmAES128,   //算法 ase128
 kCCOptionPKCS7Padding | kCCOptionECBMode,   //填充模式，比如使用ase128算法，要求数据最小长度是128bit，当数据没达到长度是的填充数据策略
 keyPtr, //密钥
 kCCBlockSizeAES128,  //密钥大小
 NULL,   //偏移量
 [self bytes], dataLength,   //数据和数据长度
 buffer, bufferSize,  &numBytesDecrypted);  返回数据
 
 //CBC模式
 kCCOptionPKCS7Padding
 //ECB模式
 kCCOptionPKCS7Padding | kCCOptionECBMode
 */
- (NSData *)AES128EncryptWithData:(NSData *)key iv:(NSData *)iv{
    NSData *retData = nil;
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        retData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return retData;
}

//解密data
- (NSData *)AES128DecryptWithData:(NSData *)key iv:(NSData *)iv
{
    
    NSData *retData = nil;
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        retData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return retData;
}


- (NSString *)CRC16
{
    Byte crcByte[2] = {0x00, 0x00};
    unsigned int crcInt = [self crcData16];
    memcpy(&crcByte, &crcInt, 2);
    NSString *usiStr = [NSString stringWithFormat:@"%2X%2X", crcByte[1],crcByte[0]];
    usiStr = [usiStr stringByReplacingOccurrencesOfString:@" " withString:@"0"];
    return usiStr;
}


- (unsigned short)crcData16{
    int start = 0; //选择数据要计算CRC的起始位
    int end = (uint16_t)[self length]; //选择数据要CRC计算的范围段
    
    unsigned short  crc = 0xffff; // initial value
    unsigned short  polynomial = 0x1021; // poly value
    Byte codeKeyByteAry[self.length];
    for (int i = 0 ; i < self.length; i++) {
        NSData *idata = [self subdataWithRange:NSMakeRange(i, 1)];
        codeKeyByteAry[i] =((Byte*)[idata bytes])[0];
    }
    for (int index = start; index < end; index++){
        Byte b = codeKeyByteAry[index];
        for (int i = 0; i < 8; i++) {
            Boolean bit = ((b >> (7 - i) & 1) == 1);
            Boolean c15 = ((crc >> 15 & 1) == 1);
            crc <<= 1;
            if (c15 ^ bit)
                crc ^= polynomial;
        }
    }
    crc &= 0xffff;
    return crc;
}


@end
