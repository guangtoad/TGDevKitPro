//
//  MaskView.m
//  smartGLink_cn
//
//  Created by toad on 2018/3/12.
//  Copyright © 2018年 TechnoASKA. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView
- (MaskView * (^)(CGRect))create{
    return ^(CGRect create){
        return [[MaskView alloc] initWithFrame:create];
    };
}
- (void)drawRect:(CGRect)rect {
    CGMutablePathRef path = CGPathCreateMutable(); //指定矩形
    CGRect rectangle = self.bounds; //将矩形添加到路径中
    CGPathAddRect(path,NULL, rectangle); //获取上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext(); //将路径添加到上下文
    CGContextAddPath(currentContext, path); //设置矩形填充色
    CGContextSetFillColorWithColor(currentContext,
    [UIColor colorWithWhite:0.0f alpha:0.8f].CGColor);
    CGContextFillRect(currentContext, rectangle);
    CGContextClearRect(currentContext, CGRectMake(50.f, 50.f, 220.f, 220.f));//绘制
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
