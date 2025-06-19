//
//  AlertController.m
//  ObjCDome
//
//  Created by toad on 2017/12/4.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "AlertController.h"

@interface AlertController ()

@end

@implementation AlertController

- (id) initWithController:(UIViewController *)controller
                    title:(NSString *)title
                    messg:(NSString *)messg
              buttonTitle:(NSString *)btnTitle , ...{
    
    if (self = [super init]) {
        int i = 0;
        va_list args;
        va_start(args, btnTitle);
        if (btnTitle)
        {
            UIAlertAction *atcion = [UIAlertAction actionWithTitle:btnTitle style:i == 0 ? UIAlertActionStyleCancel :UIAlertActionStyleDefault handler:nil];
            [atcion setValue:[UIColor blackColor] forKey:btnTitle];
            [self addAction:atcion];
        }
        va_end(args);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
