//
//  EncryptUtil.h
//  EncryptionToolBox
//
//  Created by toad on 2022/04/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncryptUtil : NSObject
+ (NSString *) RSAEncryptString:(NSString *)str publicKey:(NSString *)pubKey;
@end

NS_ASSUME_NONNULL_END
