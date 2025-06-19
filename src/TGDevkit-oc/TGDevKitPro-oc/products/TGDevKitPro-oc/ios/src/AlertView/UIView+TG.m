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

- (void) printAllSubViewStr:(NSString *)str{
    for (int i = 0 ; i < [self subviews].count; i++) {
        id obj = self.subviews[i];
        
        NSString *tStr = i <[self subviews].count - 1 ? @"├────": @"└────";
        NSString *className = NSStringFromClass([obj class]);
        NSString *Nstr = [NSString stringWithFormat:@"%@%@%@",str , tStr,className];
        printf("\n%s",[Nstr UTF8String]);
        
        [obj printAllSubViewStr:[@"|     " stringByAppendingString:str]];
    }
    for (id obj in [self subviews]) {
        
    }
//    printf("\n%s",[NSStringFromClass([self class]) UTF8String]);
}
- (void) printAllSubView{
    printf("\n%s",[NSStringFromClass([self class]) UTF8String]);
    [self printAllSubViewStr:@""];
    printf("\n");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
