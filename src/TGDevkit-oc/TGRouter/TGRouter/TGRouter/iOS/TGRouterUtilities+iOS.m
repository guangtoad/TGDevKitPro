//
//  TGRouterHandler+iOS.m
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGRouterUtilities+iOS.h"

@implementation TGRouterUtilities (iOS)

+ (UIViewController *) viewControllerWithClass:(Class)class path:(NSString *)path params:(NSDictionary<NSString *,id> *)params{
    UIViewController *viewController = nil;
    NSString *nibName = [params objectForKey:TGRouter_Key_NibName];
    NSString *storyboardName = [params objectForKey:TGRouter_Key_StoryboardName];
    NSString *identifier = [params objectForKey:TGRouter_Key_Identifier];
    NSBundle *bundle = [params objectForKey:TGRouter_Key_Bundle];
    if (nibName.length > 0) {
//        NSString *nibPath = [[NSBundle mainBundle] pathForResource:nibName ofType:@"xib"];
//        NSData *nibData = [NSData dataWithContentsOfFile:nibPath];
//        UINib *nib = [UINib nibWithData:nibData bundle:bundle];
//        [[NSCoder alloc] init]
//        [[UIViewController alloc] ini]
//        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
//        [NSData ]
//        [[UIViewController alloc] initWithCoder:<#(nonnull NSCoder *)#>]
        viewController = [[UIViewController alloc] initWithNibName:nibName bundle:bundle];
    }
    else if (storyboardName.length > 0) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
        if (identifier.length > 0) {
            viewController = [storyBoard instantiateViewControllerWithIdentifier:identifier];
        }
        else {
            viewController = [storyBoard instantiateInitialViewController];
        }
    }
    else {
        viewController = [[class alloc] init];
    }
    if (nil != viewController) {
        BOOL hidesBottomBarWhenPushed = [[params objectForKey:TGRouter_Key_HidesBottomBar] boolValue];
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
    }
    
    return viewController;
}

@end
