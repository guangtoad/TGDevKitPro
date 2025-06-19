//
//  UIAlertView.m
//  ObjCDome
//
//  Created by toad on 2017/11/30.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "UIAlertView.h"

@implementation TGAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        NSMutableArray *newOtherButtonTitles;
        if (otherButtonTitles != nil) {
            va_list args;
            va_start(args, otherButtonTitles);
            newOtherButtonTitles = [[NSMutableArray alloc] initWithObjects:otherButtonTitles, nil];
            id obj;
            while ((obj = va_arg(args, id)) != nil) {
                [newOtherButtonTitles addObject:obj];
            }
            va_end(args);
        }
        
        [self setupWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:newOtherButtonTitles];
    }
    return self;
}

@end
