//
//  BaseStackView.m
//  TGMacApp
//
//  Created by toad on 2020/5/13.
//  Copyright © 2020 toad. All rights reserved.
//

#import "BaseStackView.h"

@implementation BaseStackView

- (id) initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
