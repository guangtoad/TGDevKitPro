//
//  UIResponder+TG.h
//  WeiShop
//
//  Created by toad on 16/5/25.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (UIKeyboardNotification)

- (void) keyboardWillShowNotification:(NSNotification *)note;
- (void) keyboardWillHideNotification:(NSNotification *)note;

- (void) addKeyboardResponderObserver;
- (void) removeKeyboardResponderObserver;

@end

@interface UIResponder (TG)

@end
