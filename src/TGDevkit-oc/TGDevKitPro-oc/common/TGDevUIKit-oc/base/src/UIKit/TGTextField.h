//
//  TGTextField.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGMacros.h"

@interface TGTextField : UITextField

@property (nonatomic,assign) NSInteger maxlen;

- (void) registerForKVO;
- (void) unregisterFromKVO;

@end
