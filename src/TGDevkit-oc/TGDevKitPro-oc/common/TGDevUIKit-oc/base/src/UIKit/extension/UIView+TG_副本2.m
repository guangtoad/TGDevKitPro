//
//  UIView+TG.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "UIView+TG.h"


@implementation UIView (ViewController)

- (UIViewController*) viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

@implementation UIView (Gesture)

- (void) addTapTarget:(id)target action:(SEL)selecor{
    UITapGestureRecognizer *taGpestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:selecor];
    [self addGestureRecognizer:taGpestureRecognizer];
    return;
}

- (void) hidKeyboard{
    [self endEditing:true];
    return;
}
- (void) endEditingFun{
    [self endEditing:true];
    return;
}

- (void) addEndEditingGesture{
    [self addTapTarget:self action:@selector(endEditingFun)];
    return;
}

@end

@implementation UIView (Radius)

- (void) setupRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setMasksToBounds:YES];
    return;
}

- (void) setupBorderWidth:(float)width Color:(CGColorRef )gcolor{
    self.layer.borderWidth = width;
    self.layer.borderColor = gcolor;
}

@end

@implementation UIView (Round)

- (void) setupRound{
    [self setupRadius:CGRectGetWidth(self.frame) / 2.0];
}

@end

@implementation UIView (TG)

@end
