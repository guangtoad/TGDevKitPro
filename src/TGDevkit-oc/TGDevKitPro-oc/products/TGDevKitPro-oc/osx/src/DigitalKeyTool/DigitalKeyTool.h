//
//  DigitalKeyTool.h
//  DigitalWhiteBox
//
//  Created by greatrong on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import "BleProtocolFrameModel.h"
#import "DigitalMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface DigitalKeyTool : NSObject

//单例
+ (DigitalKeyTool*)sharedInstance;


+ (NSString *)isBlankString:(NSString *)string;

// 判断字符串是否为空
+ (BOOL)isEmpty:(NSString *)string;

/**
 *Ascii转十六进制
 *@param string Ascii码
 */

+ (NSString *)hexStringFromString:(NSString *)string;

// 十六进制转二进制
+(NSString *)getBinaryByhex:(NSString *)hex;

/**
 *二进制转换成十六进制
 */
+ (NSString *)getHexByBinary:(NSString *)binary;

/**
 *十六进制转Ascii
 */
+(NSString*)getASCIIString:(NSString*)string;

+ (NSMutableData*)convertHexStrToData:(NSString*)string;


+ (NSString *)convertDataToHexStr:(NSData *)data;
/**
 字符串倒叙
 */
+(NSString *)reversalString:(NSString *)originString;

/**
 *将data转换为不带<>的字符串
 * @param data 二进制数
 */
+ (NSString *)convertToNSStringWithNSData:(NSData *)data;

/**
 16位随机数
 */
+(NSString *)randomString;

/**
 *蓝牙配对码
 *@param vinCodel vin码
 *@param num 随机数
 */
+(NSString *)getBlePeiCode:(NSString *)vinCodel withCode:(NSString *)num;

/**
 *payload处理
 */
+(NSString *)getPayloadFromCarHex:(NSString *)payload;

/**
 对蓝牙验证payload处理
 */
+(NSMutableArray *)authTLVPayloadTransfer:(NSString *)payloadHex;

/**
 对蓝牙验证payload处理
 */
//MARK: 蓝牙数据payload处理
+(NSMutableArray *)logTLVPayloadTransfer:(NSString *)payloadHex;

//将十进制转化为十六进制
+(NSString *)ToHex:(int)tmpid;

/**
 *将十进制转化为十六进制 补0 eg: 0x111 to @"0111"
 *@param number 十进制数
 */
+(NSString *)ToHexSrtingByFillZero:(NSInteger)number;

/**
 对payload处理
 */
+(NSArray *)TLVPayloadTransfer:(NSString *)payloadHex;

/**
 *拼接成tlv字符串
 *@param type t
 *@param value  v
 */
+(NSString *)tlvConstantsAdd:(int)type value:(NSString *)value;

+(NSMutableData *)tlvDataConstantsAdd: (Byte)type value: (NSMutableData*)valueData;

/**
 字典转json
 */
+(NSString *)toJsonStrWithDictionary:(NSDictionary *)dict;

+(NSString *)convertToJsonData:(NSDictionary *)dict;

// MARK: 设备ID 查询
+(NSString *)getDeviceId;

+(NSString *)reverseHexString:(NSString *)hexString;

/**
 添加补80
 */
+(NSString *)bodyAddFill80:(NSString *)bodyString;

/**
 手机品牌
 */
+(NSString*) getDeviceModel;

/**
 手机型号
 */
+(NSString*) getManufacturer;

/**
 获取当前时间
 */
+(NSString *)getCurrentTimes;

/**
 *NSDate转字符串
 *@param str 日期数据源
 */
+(NSString *)dateLongFromString:(NSDate *)str;

/**
 是否ios 11.0及其以上版本
 */
+(BOOL)isSupportDigitalKey;


@end

NS_ASSUME_NONNULL_END
