//
//  ViewController.m
//  NewPickView
//
//  Created by toad on 2017/11/21.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "ViewController.h"
#import "TGPickerView.h"

@interface ViewController ()
@property (nonatomic,strong) TGPickerView *pickview;
@end

@implementation ViewController

- (TGPickerView *)pickview{
    if (!_pickview) {
        _pickview = [[TGPickerView alloc] initWithView:self.view];
//        [_pickview setType:NewPickerTypeTime];
    }
    return _pickview;
}
- (IBAction) clickShow:(id)sender{
    [self.pickview show];
    CGRect frame = self.pickview.frame;

//    [UIView animateWithDuration:0.2 animations:^{
//        self.pickview.transform = CGAffineTransformMakeTranslation(0, - 258);
//        self.pickview.alpha = 0.2;
//    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
