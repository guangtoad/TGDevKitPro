//
//  TGCheckBox.h
//  TGObj
//
//  Created by toad on 15/9/22.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "TGButton.h"

@class TGCheckBox;

@protocol TGCheckBoxDelegate <NSObject>

- (void) tgCheckBox:(TGCheckBox *)checkbox;
- (BOOL) tgCheckBox:(TGCheckBox *)checkbox shouldChangeValue:(BOOL)value;

@end

@interface TGCheckBox : TGButton

@property (nonatomic,strong) id<TGCheckBoxDelegate> delegate;
@property (nonatomic,assign) BOOL on;
+ (id) checkBoxWithFrame:(CGRect)frame;

@property (nonatomic,assign) CGRect imageRect;
@property (nonatomic,assign) CGRect titleRect;

@end
