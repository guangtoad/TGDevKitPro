//
//  WebTestViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/29.
//

#import "WebTestViewController.h"
#import <WebKit/WebKit.h>
@interface WebTestViewController ()
@property (nonatomic,strong) IBOutlet WKWebView *webView;

@end

@implementation WebTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView configuration];
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
