//
//  UIViewController+TG.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "UIViewController+TG.h"

@implementation UIViewController (TG)

- (BOOL) isVisible{
    return self.isViewLoaded && self.view.window;
}
- (IBAction) goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction) touchView:(id)sender{
    [self.view endEditing:true];
    return;
}
- (void) addTouchViewAction{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchView:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

@end

@implementation UIViewController (TG_XIB)

- (id) initWithNibWithClassName{
    if (self = [self initWithNibName:NSStringFromClass(self.class) bundle:nil]) {
        
    }
    return self;
}

@end
