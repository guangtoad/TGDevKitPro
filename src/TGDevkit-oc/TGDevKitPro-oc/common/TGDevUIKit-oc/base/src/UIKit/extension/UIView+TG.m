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
@end

@implementation UIView (TGIBInspectable)

/**
 *  设置边框宽度
 *
 *  @param borderWidth 可视化视图传入的值
 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;

    self.layer.borderWidth = borderWidth;
}

/**
 *  设置边框颜 色
 *
 *  @param borderColor 可视化视图传入的值
 */
- (void)setBorderColor:(UIColor *)borderColor {

    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 可视化视图传入的值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {

    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
