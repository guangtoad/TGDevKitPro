//
//  APPURLViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/09/26.
//

#import "APPURLViewController.h"

@interface APPURLViewController ()

@property (nonatomic,weak) IBOutlet UITextView *txtUril;

@end

@implementation APPURLViewController
//
//- (void) loadView{
//    [super loadView];
//}
/// 视图加载后
- (void)viewDidLoad {
    [super viewDidLoad];
}

/// 按钮点击时间
/// @param sender 触发者
- (IBAction) click_openUrl:(id)sender{
    [self performSelectorOnMainThread:@selector(oepnUri:) withObject:self.txtUril.text waitUntilDone:true];
}

/// 打开地址
/// @param uri 地址
- (void) oepnUri:(NSString *)uri{
    @try {
        if (NULL == uri) {
            @throw [NSException exceptionWithName:@"提示" reason:@"url空了" userInfo:NULL];
        }
        NSURL *url = [NSURL URLWithString:uri];
        if (NULL == url) {
            @throw [NSException exceptionWithName:@"提示" reason:[NSString stringWithFormat:@"url格式错误:%@",uri] userInfo:NULL];
        }
        UIApplication *sharedApplication = [UIApplication sharedApplication];
        if (![sharedApplication canOpenURL:url]) {
            @throw [NSException exceptionWithName:@"提示" reason:[NSString stringWithFormat:@"url无法打开:%@",uri] userInfo:NULL];
        }
        [sharedApplication openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    } @catch (NSException *exception) {
        [self showAlert:exception.reason handler:NULL];
    } @finally {
        
    }
}

@end
