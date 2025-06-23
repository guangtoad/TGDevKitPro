//
//  BaseView.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/25.
//

#import "BaseView.h"

@implementation BaseView

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBaseBackcolor];
    }
    return self;
}


@end
