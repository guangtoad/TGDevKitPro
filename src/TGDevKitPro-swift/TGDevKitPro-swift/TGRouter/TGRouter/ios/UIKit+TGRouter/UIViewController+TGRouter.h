//
//  UIViewController+TGRouter.h
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TGRouterDefs.h"
#import "TGRouterUtilities+iOS.h"
#import "TGRouterHandler.h"
#import "TGRouterCenter.h"
//#import <TG_ObjC.h>

NS_ASSUME_NONNULL_BEGIN
// TODO: asds
// MARK: mark
// FIXME: FIXME
@interface UIViewController (TGRouterPage)

@end

@interface UIViewController (TGRouter)

/**
 ///# 标题1

 @param URL <#URL description#>
 @return <#return value description#>
 */
- (BOOL) openURL:(NSURL * __nullable)URL;

/**
 通过url打开页面
 
 支持 present，pust
 
 @code
 [self openURLStr:@"pust://UIViewController?key=value"]
 @endcode
 
 @return 是否打开成功asd
 @Authors toad
 @Date: 15 July 当前开发时间
 @Since: iOS 8.0
 @Version: 2.26
 */
- (BOOL) openURLStr:(NSString * __nullable)URLStr;
- (BOOL) openScheme:(NSString * __nullable)scheme host:(NSString * __nullable)host path:(NSString * __nullable)path params:(NSDictionary<NSString *,id> * __nullable)params  handler:(TGRouterHandler * __nullable)handler completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
