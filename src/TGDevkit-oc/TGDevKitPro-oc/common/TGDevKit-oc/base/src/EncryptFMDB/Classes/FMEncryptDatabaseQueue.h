//
//  FMEncryptDatabaseQueue.h
//  smartGLink_cn
//
//  Created by syqb on 2022/5/7.
//  Copyright © 2022 TechnoASKA. All rights reserved.
//

#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMEncryptDatabaseQueue : FMDatabaseQueue

- (nullable instancetype)initWithPath:(NSString * _Nullable)aPath encryptKey:(NSString *_Nullable)encryptKey;

@end

NS_ASSUME_NONNULL_END
