//
//  WechatTestViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/15.
//

#import "WechatTestViewController.h"

@interface WechatTestViewController ()

@property (nonatomic,assign) BOOL isRegister;

@property (weak, nonatomic) IBOutlet UITextField *txtAPPID;
@property (weak, nonatomic) IBOutlet UITextField *txtLink;
@property (weak, nonatomic) IBOutlet UITextView *txtLog;

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPath;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segType;

@end

@implementation WechatTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
