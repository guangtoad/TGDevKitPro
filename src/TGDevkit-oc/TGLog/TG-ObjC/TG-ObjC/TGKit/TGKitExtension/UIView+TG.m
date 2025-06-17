//
//  UIView+TG.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "UIView+TG.h"

@implementation UIView (TG)

- (void) treeStr:(NSString *)str level:(NSInteger)level{
    for (UIView *view in [self subviews]) {
        NSString *pStr = [NSString stringWithFormat:@"%@%@%@",str,NSStringFromClass([view class]),NSStringFromCGRect(view.frame)];
        printf("%s\n",[pStr UTF8String]);
        [view treeStr:[str stringByAppendingString:str] level:level + 1];
    }
}
- (void) tree{
    printf("\n%s",[NSStringFromClass([self class]) UTF8String]);
    [self treeStr:@"-" level:0];
    printf("\n");
}

- (void) setCornerRadius:(CGFloat)radius{
    self.layer.masksToBounds = radius > 0 ? true:false;
    self.layer.cornerRadius = radius;
}

@end
