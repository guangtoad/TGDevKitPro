//
//  LaunchViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@property (nonatomic,strong) IBOutlet UILabel *txtStatus;

@end

@implementation LaunchViewController

+ (id) createViewContoller{
    id viewController = NULL;n    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"" ofType:@""];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = false;
    BOOL isExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    UINib *nin = [UINib nibWithData:NULL bundle:NULL];
    if (isExists && !isDirectory) {
        viewController = [[self alloc] initWithNibName:@"" bundle:bundle];
    }
    else {
        viewController = [[self alloc] init];
    }
    return viewController;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

@end
