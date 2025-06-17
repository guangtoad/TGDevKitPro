//
//  TGViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "TGViewController.h"

@interface TGViewController ()

@end

@implementation TGViewController

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
