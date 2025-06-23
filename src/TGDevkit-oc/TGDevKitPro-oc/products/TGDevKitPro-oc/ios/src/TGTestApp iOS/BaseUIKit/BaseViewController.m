//
//  BaseViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/25.
//

#import "BaseViewController.h"

@implementation UIViewController (Base)


@end

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBaseBackcolor];
}

@end

@implementation BaseTableViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBaseBackcolor];
}

@end

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
}

- (void) dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void) presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
