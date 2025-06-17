//
//  ViewController.m
//  EncryptTool
//
//  Created by home on 2018-07-26.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "ViewController.h"
#import "MDDD.h"
@implementation ViewController

- (IBAction)click_up:(id)sender {
    NSString *str = self.inputtxt.stringValue;
    self.md532txt.stringValue = [str md5Uppercase];
    self.md5txt16.stringValue = [str md516Uppercase];
}
- (IBAction)click_lose:(id)sender {

    NSString *str = self.inputtxt.stringValue;
    self.md532txt.stringValue = [str md5Lowercase];
    self.md5txt16.stringValue = [str md516Lowercase];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
