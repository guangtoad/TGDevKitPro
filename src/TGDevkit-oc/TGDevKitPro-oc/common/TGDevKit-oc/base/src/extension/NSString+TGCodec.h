//
//  NSString+TGCodec.h
//  TGFoundation
//
//  Created by toad on 2022/07/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TGCodec)
#pragma mark - BASE64
/// BASE64编码
- (NSString * _Nullable) tg_base64Encode;
/// Base64解码
- (NSString * _Nullable) tg_base64Decode;

#pragma mark - URLEncode
/// UrlEncode 编码
- (NSString * _Nonnull) tg_urlEncode;
/// UrlDecode 解码
- (NSString * _Nonnull) tg_urlDecode;

#pragma mark - Localized
+ (NSString * _Nullable) tg_localizedStringForKey:(NSString *)key bundle:(nullable NSBundle *)bundle;
+ (NSString * _Nullable) tg_localizedStringForKey:(NSString *)key;

@end

/// 正则
@interface NSString(validate)

/// 匹配正则
/// @param regex regex 正则表达式
/// @return 匹配结果
- (BOOL) regexByStr:(NSString *)regex;

/// 邮箱验证 MODIFIED BY HELENSONG
/// @return 结果
- (BOOL) isValidateEmail;

/// 普通车牌检查
/// @return 匹配结果
-(BOOL) isValidateNomalCar;

/// 使馆车辆检查
/// @return 结果
-(BOOL) isValidateEmbassyCar;

/// 军队车辆检查
/// @return 结果
-(BOOL) isValidateArmyCar;

/// 警车检查
/// @return 检查结果
-(BOOL) isValidatePoliceCar;

/// 车牌号校验
/// @return 检查结果
- (BOOL) isValidateCarNumber;

@end
NS_ASSUME_NONNULL_END

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
- (NSDate * _Nullable) tg_dateWithFormatter:(NSString * _Nullable)formatterStr;

- (NSDate * _Nullable) tg_dateWithFormatter:(NSString * _Nullable)formatterStr locale:(NSLocale *)locale timeZone:(NSTimeZone *)timeZone;

@end
