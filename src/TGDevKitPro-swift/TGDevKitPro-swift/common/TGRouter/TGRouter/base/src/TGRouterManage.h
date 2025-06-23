//
//  TGRouterManage.h
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGRouterHandler.h"
#import "UIKit+TGRouter.h"
NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^TGRouterCheckUrlBlock)(NSString *url);

@interface TGRouterManage : NSObject

@property (nonatomic,weak) TGRouterCheckUrlBlock checkUrlBlock;
//@property (nonatomic,weak) TGRouterWillOpenBlock willOpenBlock;

+ (instancetype) shareInstance;
+ (TGRouterManage *) defaultManager;

@end

NS_ASSUME_NONNULL_END
