//
//  TGRouterHandler+iOS.h
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGRouterUtilities.h"
#import "TGRouterDefs.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGRouterUtilities  (iOS)

+ (UIViewController *) viewControllerWithClass:(Class)class path:(NSString *)path params:(NSDictionary<NSString *,id> *)params;



@end

NS_ASSUME_NONNULL_END
