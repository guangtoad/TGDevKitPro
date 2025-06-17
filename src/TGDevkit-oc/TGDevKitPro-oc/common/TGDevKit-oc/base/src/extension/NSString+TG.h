//
//  NSString+TG.h
//  TG-ObjC
//
//  Created by toad on 2019/3/30.
//  Copyright © 2019 toad. All rights reserved.
//

#import "NSString+TGEncrypt.h"
#import "NSString+TGExtension.h"
#import "NSString+TGRegex.h"

/**
 NSString 扩展
 */
@interface NSString (TG)

/**
 去除两端空格

 @return 去掉空格后字符串
 */
- (NSString *) trim;
/**
 检测字符串是否为空

 @param str 字符串
 @return = nil || ""
 */
+ (BOOL) IsNullOrEmpty:(NSString *)str;
/**
 检测字符串是否为空或全空格

 @param str 字符串
 @return 是否为空或全空格
 */
+ (BOOL) IsNullOrWhiteSpace:(NSString *)str;
/**
 UrlEncode编码

 @return 编码后字符串
 */
- (NSString *) urlEncode;
/**
 UrlDecode解码

 @return 解码后字符串
 */
- (NSString *) urlDecode;
@end
