//
//  UIResponder+TG.m
//  WeiShop
//
//  Created by toad on 16/5/25.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "UIResponder+TG.h"

@implementation UIResponder (UIKeyboardNotification)

- (void) keyboardWillShowNotification:(NSNotification *)note {
    return;
}
- (void) keyboardWillHideNotification:(NSNotification *)note {
    return;
}

- (void) addKeyboardResponderObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    return;
}
- (void) removeKeyboardResponderObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    return;
}

@end

@implementation UIResponder (TG)

@end
