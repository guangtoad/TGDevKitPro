//
//  UIView+TG.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "UIView+TG.h"

@implementation UIView (TG)

- (void) setCornerRadius:(CGFloat)radius{
    self.layer.masksToBounds = radius > 0 ? true:false;
    self.layer.cornerRadius = radius;
}

@end
