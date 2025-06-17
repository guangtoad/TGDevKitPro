//
//  ViewController.m
//  GLIHONETest
//
//  Created by home on 2018/5/23.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomView *view = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
