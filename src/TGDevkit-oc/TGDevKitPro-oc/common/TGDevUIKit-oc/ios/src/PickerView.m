//
//  PickerView.m
//  ObjCDome
//
//  Created by home on 2017/12/1.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "PickerView.h"
//
//@interface PickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
//
//@end

@implementation PickerView
- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self reloadAllComponents];
    }
    return self;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch began");
}
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch moved");
}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touches ended");
}

@end
