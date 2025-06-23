//
//  User.h
//  TGTestApp iOS
//
//  Created by toad on 2022/08/01.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic,assign) BOOL authenticated;
@property (nonatomic,assign) NSInteger state;
/// IPD 用户ID
@property (nonatomic,assign) NSString *USERID;
/// IDP 用户名
@property (nonatomic,assign) NSString *USERNAME;
/// 密码
@property (nonatomic,assign) NSString *USER_PWD;
/// 激活状态
@property (nonatomic,assign) NSString *ACTIVATED;
/// 用户手机号
@property (nonatomic,assign) NSString *PHONE_NUMBER;
/// 用户唯一标识
@property (nonatomic,assign) NSString *USER_GUID;

@property (nonatomic,strong) NSMutableArray<Vehicle *> *vehicles;

@end

NS_ASSUME_NONNULL_END
