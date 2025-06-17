//
//  TGRouterHandler.h
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^TGRouterHandlerWillOpenBlock)(NSString *url);

@interface TGRouterHandler : NSObject

@end

NS_ASSUME_NONNULL_END
