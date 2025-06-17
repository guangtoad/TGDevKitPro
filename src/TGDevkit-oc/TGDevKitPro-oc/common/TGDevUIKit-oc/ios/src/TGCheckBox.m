//
//  TGCheckBox.m
//  TGObj
//
//  Created by toad on 15/9/22.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "TGCheckBox.h"

@interface TGCheckBox (){
//    id t_target;
//    SEL t_action;
}

@end

@implementation TGCheckBox

- (void) dealloc{
//    t_action = nil;
//    t_target = nil;
    TGDealloc;
}

- (IBAction) didSelectSelf:(id)sender{
    BOOL willChange = true;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tgCheckBox:shouldChangeValue:)]) {
        willChange = [self.delegate tgCheckBox:self shouldChangeValue:!self.on];
    }
    if (willChange) {
        [self setOn:!self.on];
    }
}

- (id) init{
    TGLOGFUN();
    if (self = [super init]) {
        
    }
    return self;
}
- (id) initWithFrame:(CGRect)frame{
    TGLOGFUN();
    if (self = [super initWithFrame:frame]) {
        [super addTarget:self action:@selector(didSelectSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    //    TGLOG(@"imageRectForContentRect:%@",NSStringFromCGRect(contentRect));
    if (!CGRectIsEmpty(self.imageRect)) return self.imageRect;
    return contentRect;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
   
    if (! CGRectIsEmpty(self.titleRect)) {
        return self.titleRect;
    }
    else if (! CGRectIsEmpty(self.imageRect)) {
        CGRect frame = CGRectZero;
        
        self.titleRect = frame;
    }
    return contentRect;
}

- (void) setOn:(BOOL)on{
    _on  = on;
    [self setSelected:_on];
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event{
    TGLOGFUN();
}
- (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event{
    [super sendAction:action to:target forEvent:event];
    TGLOGFUN();
}
- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents{
    TGLOGFUN();
}

+ (id) checkBoxWithFrame:(CGRect)frame{
    return nil;
}

//- (void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
//    if (controlEvents != UIControlEventTouchUpInside) {
//        [super addTarget:target action:action forControlEvents:controlEvents];
//        return;
//    }
//    t_target = target;
//    t_action = action;
//}

@end
