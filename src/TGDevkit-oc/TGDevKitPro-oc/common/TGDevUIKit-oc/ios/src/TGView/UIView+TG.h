//
//  UIView+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+TG.h"


@interface UIView (ViewController)

- (UIViewController *)viewController;

@end

@interface UIView (Gesture)

- (void) addTapTarget:(id)target action:(SEL)selecor;
- (void) hidKeyboard;
- (void) endEditingFun;
- (void) addEndEditingGesture;

@end


@interface UIView (Radius)

- (void) setupRadius:(CGFloat)cornerRadius;
- (void) setupBorderWidth:(float)width Color:(CGColorRef)color;

@end

@interface UIView (Round)

- (void) setupRound;

@end

@interface UIView (TG)

@end
