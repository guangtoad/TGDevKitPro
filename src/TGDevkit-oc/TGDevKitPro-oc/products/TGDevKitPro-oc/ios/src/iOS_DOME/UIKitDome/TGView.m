//
//  TGView.m
//  iOS_DOME
//
//  Created by toad on 2018/1/31.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGView.h"

@implementation TGView

- (BOOL) endEditing:(BOOL)force{
    NSLog(@"end editing");
    return [super endEditing:force];
}

- (BOOL) resignFirstResponder{
    NSLog(@"resig first responder");
    
    return [super resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
