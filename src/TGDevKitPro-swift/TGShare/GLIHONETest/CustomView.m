//
//  CustomView.m
//  GLIHONETest
//
//  Created by home on 2018/5/23.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "CustomView.h"


@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
    }
    return self;
}


// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextClearRect(context, rect);//添加这句代码
    /*写文字*/
    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    CGContextSetRGBStrokeColor(context,1, 0, 0, 1.0);

    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(CGRectGetMidX(rect), 0);//坐标1
    sPoints[1] =CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));//坐标2
    sPoints[2] =CGPointMake(0, CGRectGetMaxY(rect));//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径


}


@end
