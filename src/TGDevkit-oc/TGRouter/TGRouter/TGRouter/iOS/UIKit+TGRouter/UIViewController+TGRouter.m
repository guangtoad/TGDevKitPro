//
//  UIViewController+TGRouter.m
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "UIViewController+TGRouter.h"

@implementation UIViewController (TGRouterPage)

@end

@implementation UIViewController (TGRouter)

- (BOOL) openViewController:(UIViewController *)viewController Scheme:(NSString * __nullable)scheme host:(NSString * __nullable)host path:(NSString * __nullable)path params:(NSDictionary<NSString *,id> * __nullable)params  handler:(TGRouterHandler * __nullable)handler completion:(void (^ __nullable)(void))completion{
//    if ([TGRouter_Scheme_Push isEqualToString:scheme] || [TGRouter_Scheme_Present isEqualToString:scheme]) {
//
//    }
    return false;
}

- (BOOL) openScheme:(NSString * __nullable)scheme host:(NSString * __nullable)host path:(NSString * __nullable)path params:(NSDictionary<NSString *,id> * __nullable)params  handler:(TGRouterHandler * __nullable)handler completion:(void (^ __nullable)(void))completion{
    
    if ([TGRouter_Scheme_Push isEqualToString:scheme] || [TGRouter_Scheme_Present isEqualToString:scheme]) {
        
        if (!host || host.length < 1) {
            return false;
        }
        Class class = NSClassFromString(host);
        if (!class ){
            return false;
            
        }
        else if (![class isSubclassOfClass:[UIViewController class]]){
            return false;
            
        }
        if (!class || ![class isSubclassOfClass:[UIViewController class]]) {
            return false;
        }
        
        UIViewController *viewController = [TGRouterUtilities viewControllerWithClass:class path:path params:params];
        
        BOOL animated = true;// = [[params objectForKey:TGRouter_Key_Animated] boolValue];
        if (nil != viewController) {
            if ([TGRouter_Scheme_Push isEqualToString:scheme]) {
                if (nil != self.navigationController) {
                    [self.navigationController pushViewController:viewController animated:animated];
                    if (nil != completion) {
                        completion();
                    }
                    return true;
                }
            }
            else if ([TGRouter_Scheme_Present isEqualToString:scheme]) {
                [self presentViewController:viewController animated:animated completion:completion];
                return true;
            }
        }
    }
    return false;
}

- (BOOL) openURL:(NSURL * __nullable)URL params:(NSDictionary<NSString *,id> *__nullable)params handler:(TGRouterHandler * __nullable)handler completion:(void (^ __nullable)(void))completion{
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:URL resolvingAgainstBaseURL:false];
    if (nil != urlComponents) {
        NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;
        if (nil != queryItems && queryItems.count > 0) {
            NSMutableDictionary *all_params = [[NSMutableDictionary alloc] initWithDictionary:params];
            for (NSURLQueryItem *item in queryItems) {
                [all_params setObject:item.value forKey:[item.name lowercaseString]];
            }
            return [self openScheme:urlComponents.scheme host:urlComponents.host path:urlComponents.path params:all_params handler:handler completion:completion];
        }
    }
    return [self openScheme:[URL.scheme lowercaseString] host:URL.host path:URL.path params:params handler:handler completion:completion];
}

- (BOOL) openURLStr:(NSString *)URL params:(NSDictionary<NSString *,id> *)params handler:(TGRouterHandler * __nullable)handler completion:(void (^ __nullable)(void))completion{
    return [self openURL:[NSURL URLWithString:URL] params:params handler:handler completion:completion];
}

- (BOOL) openURL:(NSURL * __nullable)URL{
    return [self openURL:URL params:nil handler:nil completion:nil];
}

- (BOOL) openURLStr:(NSString * __nullable)URLStr{
    return [self openURL:[NSURL URLWithString:URLStr] params:nil handler:nil completion:nil];
}

- (BOOL) canOpenURL:(NSString *)URL{
    BOOL result = false;
    return result;
}
- (BOOL) openURL:(NSURL *)url{
    NSString *scheme = [url.scheme lowercaseString];
    NSURLComponents *componts = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:false];
    NSArray<NSURLQueryItem *> *queryItems = componts.queryItems;
//    NSMutableDictionary *
//    for (NSURLQueryItem *item in queryItems) {
//
//    }
    
//    if ([@"push" isEqualToString:scheme]) {
//
//    }
//    else {
//
//    }
    return true;
}

- (BOOL) openURLStr:(NSString *)url{
    BOOL result = false;
    
    NSArray<NSURLQueryItem *> *queryItems = [[NSURLComponents alloc] initWithURL:[[NSURL alloc] initWithString:url] resolvingAgainstBaseURL:false].queryItems;
    id myObj = [[NSClassFromString(@"MySpecialClass") alloc] init];
    return result;
}

- (BOOL) back:(NSInteger)index{
    BOOL result = false;
    return result;
}

@end
