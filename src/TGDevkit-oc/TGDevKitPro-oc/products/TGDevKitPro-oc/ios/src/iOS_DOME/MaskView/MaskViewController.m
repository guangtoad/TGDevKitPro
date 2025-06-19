//
//  MaskViewController.m
//  iOS_DOME
//
//  Created by toad on 2018/3/13.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "MaskViewController.h"

@interface MaskViewController ()

@end

@implementation MaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    MaskView *mask = [[MaskView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mask];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
