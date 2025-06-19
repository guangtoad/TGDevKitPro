//
//  UIView+TG.m
//  ObjCDome
//
//  Created by toad on 2017/12/1.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "UIView+TG.h"

#import <Foundation/Foundation.h>
@implementation UIView (TG)

- (void) pringAllSubView{
    printf("\n%s",[NSStringFromClass([self class]) UTF8String]);
    for (id obj in []) {
        <#statements#>
    }
    [self pView:self.pickerView vv:@"└────"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
