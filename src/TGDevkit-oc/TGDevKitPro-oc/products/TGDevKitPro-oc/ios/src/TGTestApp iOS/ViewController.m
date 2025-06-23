//
//  ViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/06/01.
//

#import "ViewController.h"
//#import "TODKManager.h"
#import <sqlite3.h>
//#include <openssl/sha.h>
@interface ViewController ()<UITextFieldDelegate,NSURLSessionTaskDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate>

@end

@implementation ViewController
- (IBAction)click_alert:(id)sender{
    [self showAlertTitle:@"非常抱歉，您的证件读取失败，请您稍后尝试。如多次操作仍未成功，请联络400-818-3737。" message:@"{错误信息+错误代码}" handler:NULL];
}
+ (CGFloat) safeAreaInsetsTop{
    CGFloat result = 0;
    if (@available(iOS 13.0,*)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        result = window.safeAreaInsets.top;
    }
    else if (@available(iOS 11.0,*)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        result = window.safeAreaInsets.top;
    }
    return result;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [[TODKManager shareDKManager] DK_init];
}
- (IBAction) click_post:(id)sender{
    
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                       willBeginDelayedRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition disposition, NSURLRequest * _Nullable newRequest))completionHandler{
}

- (void)URLSession:(NSURLSession *)session taskIsWaitingForConnectivity:(NSURLSessionTask *)task{
    
}

/* An HTTP request is attempting to perform a redirection to a different
* URL. You must invoke the completion routine to allow the
* redirection, allow the redirection with a modified request, or
* pass nil to the completionHandler to cause the body of the redirection
* response to be delivered as the payload of this request. The default
* is to follow redirections.
*
* For tasks in background sessions, redirections will always be followed and this method will not be called.
*/


#pragma mark - NSURLSessionDataDelegate


@end
