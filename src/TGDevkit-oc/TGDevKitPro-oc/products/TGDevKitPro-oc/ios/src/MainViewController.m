//
//  MainViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

+ (id) createViewContoller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MacOSMain" bundle:NULL];
    return  storyboard.instantiateInitialViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
