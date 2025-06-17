//
//  NSString+SHA256.h
//  HouPu
//
//  Created by 雷建民 on 17/1/3.
//  Copyright © 2017年 杭州后铺信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (SHA256)

- (NSString *)SHA256;

/**
// AES128_CBC模式加密
// */
//-(NSString *)aes128_encrypt:(NSString*)string Withkey:(NSString *)key ivkey:(NSString *)ivkey;
//
///**
// AES128_ECB模式加密
// */
//-(NSString *)aes128_ebcencrypt:(NSString*)string Withkey:(NSString *)key ivkey:(NSString *)ivkey;
//
///**
// aes128加密
// */
//-(NSString *)aes128Encrypt:(NSString *)plainText key:(NSString *)key;


@end
