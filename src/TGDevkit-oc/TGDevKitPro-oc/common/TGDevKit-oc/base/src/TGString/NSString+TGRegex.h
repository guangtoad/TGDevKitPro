//
//  NSString+TGRegex.h
//  LancareAPP
//
//  Created by toad on 2017/7/8.
//  Copyright © 2017年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(NSString_Ext)

// md5 加密
- (NSString *)MD5Hash;

+ (NSString *)getStringFromGBGBase64String:(NSString *)strSource;

/**
 base64加密

 @return 加密后
 */
- (NSString *) base64;

/**
 base64解密

 @return 解密后
 */
- (NSString *) decBase64;
//+ (NSString *)getBase64String:(NSString *)strSource;
@end

/**
 正则
 */
@interface NSString(validate)
/**
 匹配正则

 @param regex 正则表达式
 @return 匹配结果
 */
- (BOOL) regexByStr:(NSString *)regex;
/**
 邮箱验证 MODIFIED BY HELENSONG

 @return 结果
 */
- (BOOL) isValidateEmail;
/**
 普通车牌检查

 @return 匹配结果
 */
-(BOOL) isValidateNomalCar;

/**
 使馆车辆检查

 @return 结果
 */
-(BOOL) isValidateEmbassyCar;
/**
 军队车辆检查

 @return 结果
 */
-(BOOL) isValidateArmyCar;
/**
 警车检查

 @return 结果
 */
-(BOOL) isValidatePoliceCar;

/**
 车牌号检查

 @return 结果
 */
- (BOOL) isValidateCarNumber;
@end


@interface NSString(date)
/**
 转为nsdate
 @param formatterStr 日期格式
 @code
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 @endcode
 @remark yyyy-MM-dd HH:mm:ss.SSS
 yyyy-MM-dd HH:mm:ss
 yyyy-MM-dd
 MM dd yyyy
 @return date
 */
- (NSDate *) dateWithFormatter:(NSString *)formatterStr;

@end
