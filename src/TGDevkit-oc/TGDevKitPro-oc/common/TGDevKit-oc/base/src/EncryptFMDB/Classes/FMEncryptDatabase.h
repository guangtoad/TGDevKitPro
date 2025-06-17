//
//  FMEncryptDatabase.h
//  smartGLink_cn
//
//  Created by syqb on 2022/5/7.
//  Copyright © 2022 TechnoASKA. All rights reserved.
//

#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMEncryptDatabase : FMDatabase

+ (instancetype)databaseWithPath:(NSString*)aPath encryptKey:(NSString *)encryptKey;

- (instancetype)initWithPath:(NSString*)aPath encryptKey:(NSString *)encryptKey;

@end

NS_ASSUME_NONNULL_END
