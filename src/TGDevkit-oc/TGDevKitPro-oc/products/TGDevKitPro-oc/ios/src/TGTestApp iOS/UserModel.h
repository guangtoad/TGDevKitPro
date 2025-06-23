//
//  UserModel.h
//  TGTestApp iOS
//
//  Created by toad on 2022/07/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,assign) NSUInteger activated;

@end

NS_ASSUME_NONNULL_END
