//
//  ViewController.m
//  TGRouterDemo
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (IBAction) clickOpen:(id)sender{
    
    NSString *urlStr = [TGRouterUtilities URLStrWithScheme:TGRouter_Scheme_Push className:NSStringFromClass([UIViewController class])];
    
    [self openURLStr:[urlStr stringByAppendingFormat:@"?%@=%@",TGRouter_Key_NibName,@"V22ViewController"]];
}

- (IBAction) clickOpen2:(id)sender{
    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc animated:true completion:nil];
}

@end
