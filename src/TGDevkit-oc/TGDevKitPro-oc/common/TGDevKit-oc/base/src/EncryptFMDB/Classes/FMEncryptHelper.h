//
//  FMEncryptHelper.h
//  smartGLink_cn
//
//  Created by syqb on 2022/5/7.
//  Copyright © 2022 TechnoASKA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMEncryptHelper : NSObject

/// 加密sqlite
/// @param path path
/// @param encryptKey 秘钥
+ (BOOL)encryptDatabase:(NSString *)path encryptKey:(NSString *)encryptKey;

/// 解密sqlite
/// @param path path
/// @param encryptKey 秘钥
+ (BOOL)unEncryptDatabase:(NSString *)path encryptKey:(NSString *)encryptKey;

/// 修改秘钥
/// @param dbPath path
/// @param originKey 原秘钥
/// @param newKey 新秘钥
+ (BOOL)changeKey:(NSString *)dbPath originKey:(NSString *)originKey newKey:(NSString *)newKey;

/// 加密sqlite
/// @param sourcePath 源路径
/// @param targetPath 目标路径
/// @param encryptKey 秘钥
+ (BOOL)encryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath encryptKey:(NSString *)encryptKey;
@end

NS_ASSUME_NONNULL_END
