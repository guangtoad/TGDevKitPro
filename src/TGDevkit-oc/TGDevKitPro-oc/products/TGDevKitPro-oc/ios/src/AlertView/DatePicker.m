//
//  DatePicker.m
//  ObjCDome
//
//  Created by toad on 2017/12/1.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "DatePicker.h"

@implementation DatePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch began");
}
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch moved");
}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touches ended");
}


@end
