//
//  BaseView.m
//  TGMacApp
//
//  Created by toad on 2020/5/11.
//  Copyright © 2020 toad. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (void) awakeFromNib{
    [super awakeFromNib];
    NSColor *color = [NSColor colorNamed:@"color_bg_view"];
    self.wantsLayer = true;
    self.layer.backgroundColor = color.CGColor;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
