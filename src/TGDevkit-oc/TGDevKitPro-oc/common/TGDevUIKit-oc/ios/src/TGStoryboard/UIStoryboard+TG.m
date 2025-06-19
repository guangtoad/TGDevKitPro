//
//  UIStoryboard+TG.m
//  WeiShop
//
//  Created by toad on 2016/11/16.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "UIStoryboard+TG.h"

@implementation UIStoryboard (TG)

+ (UIViewController *) instantiateInitialViewControllerWithName:(NSString *)storyboardName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *viewController = storyboard.instantiateInitialViewController;
    return viewController;
}

@end
