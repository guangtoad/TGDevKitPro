//
//  UIStoryboard+TG.h
//  WeiShop
//
//  Created by toad on 2016/11/16.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (TG)

+ (UIViewController *) instantiateInitialViewControllerWithName:(NSString *)storyboardName;

@end
