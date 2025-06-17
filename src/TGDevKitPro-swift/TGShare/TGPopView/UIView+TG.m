//
//  UIView+TG.m
//  TGShare
//
//  Created by home on 2018/5/17.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "UIView+TG.h"

@implementation UIView (TG)

- (void) treeStr:(NSString *)str level:(NSInteger)level{
    for (UIView *view in [self subviews]) {
        NSString *pStr = [NSString stringWithFormat:@"%@%@%@",str,NSStringFromClass([view class]),NSStringFromCGRect(view.frame)];
//        NSString *pStr = [NSString stringWithFormat:@"%@V:%@\ttag:%ld\tframe:%@",str,[view class],view.tag,NSStringFromCGRect(view.frame)];
        printf("%s\n",[pStr UTF8String]);
        [view treeStr:[str stringByAppendingString:str] level:level + 1];
    }
}
- (void) tree{
    printf("\n%s",[NSStringFromClass([self class]) UTF8String]);
    [self treeStr:@"-" level:0];
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
