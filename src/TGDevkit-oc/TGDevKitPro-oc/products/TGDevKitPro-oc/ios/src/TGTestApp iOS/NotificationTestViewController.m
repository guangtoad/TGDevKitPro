//
//  NotificationTestViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/06/27.
//

#import "NotificationTestViewController.h"



@interface NotificationTestViewController ()

@end

@implementation NotificationTestViewController

- (void) onNotifyConnection:(NSNotification *)notec{
    
}
- (void)viewDidLoad {
//    [@"" hasPrefix:<#(nonnull NSString *)#>]
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ABDDD" object:NULL userInfo:NULL];
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
