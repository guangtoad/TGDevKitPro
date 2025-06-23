//
//  TODKManager.h
//  TGTestApp iOS
//
//  Created by toad on 2022/07/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TODKManager : NSObject

+ (instancetype)shareDKManager;
///初始化DK
- (void)DK_init;
@end

NS_ASSUME_NONNULL_END
