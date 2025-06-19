//
//  UIViewController+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+TG.h"

@interface UIViewController (TG)

- (IBAction) goBack:(id)sender;

- (IBAction) touchView:(id)sender;
- (void) addTouchViewAction;

- (BOOL) isVisible;

@end

@interface UIViewController (TG_XIB)

- (id) initWithNibWithClassName;

@end
