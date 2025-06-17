//
//  UIDevice+TG.m
//  TG-ObjC
//
//  Created by toad on 2019/4/2.
//  Copyright © 2019 toad. All rights reserved.
//

#import "UIDevice+TG.h"

/**
 UIDevice TG扩展
 */
@implementation UIDevice (TG)

+ (CGFloat) dpi{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat dpi = sqrt( w*w + h*h );
    return dpi;
}

@end
