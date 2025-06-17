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

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TGRouterPage)

@end

@interface UIViewController (TGRouter)

- (BOOL) openURL:(NSURL * __nullable)URL;
- (BOOL) openURLStr:(NSString * __nullable)URLStr;
- (BOOL) openScheme:(NSString * __nullable)scheme host:(NSString * __nullable)host path:(NSString * __nullable)path params:(NSDictionary<NSString *,id> * __nullable)params  handler:(TGRouterHandler * __nullable)handler completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
