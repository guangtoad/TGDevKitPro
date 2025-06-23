//
//  UITabBarController+TGRouter.m
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "UITabBarController+TGRouter.h"


@implementation UITabBarController (TGRouter)

- (BOOL) openScheme:(NSString * __nullable)scheme host:(NSString * __nullable)host path:(NSString * __nullable)path params:(NSDictionary<NSString *,id> * __nullable)params  handler:(TGRouterHandler * __nullable)handler completion:(void (^ __nullable)(void))completion{
    if ([TGRouter_Scheme_Select isEqualToString:scheme]) {
        Class class = NSClassFromString(host);
        if (nil != class) {
            NSInteger selectIndex = NSNotFound;
            for (NSInteger i = 0; i < self.viewControllers.count; i++) {
                if ([self.viewControllers[i] isKindOfClass:class]) {
                    selectIndex = i;
                    break;
                }
            }
            if (NSNotFound != selectIndex) {
                [self setSelectedIndex:selectIndex];
            }
        }
    }
    return [super openScheme:scheme host:host path:path params:params handler:handler completion:completion];
}
@end
