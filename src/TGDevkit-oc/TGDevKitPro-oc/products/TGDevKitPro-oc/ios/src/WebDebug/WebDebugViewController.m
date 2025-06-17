//
//  WebDebugViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "WebDebugViewController.h"
#import "LeakAvoider.h"

@interface WebDebugViewController ()<WKScriptMessageHandler>

@end

@implementation WebDebugViewController

- (IBAction) click_webReload:(id)sender{
    [self.webView reload];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.isDataLoaded) {
        [self reloadData];
        self.isDataLoaded = true;
    }
}
- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.webView setFrame:self.view.bounds];
    self.webView.scrollView.contentInsetAdjustmentBehavior = false;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    WKUserContentController *userContent = WKUserContentController.alloc.init;
    
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"vconsole" ofType:@"js"];
    NSString *jsString = [[NSString alloc] initWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:NULL];
    WKUserScript *userScrpit = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:true];
    [userContent addUserScript:userScrpit];
    
    [userContent addScriptMessageHandler:[[LeakAvoider alloc] initWithMessageHandler:self] name:@"jsCallBrowser"];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;
    configuration.userContentController = userContent;
    configuration.selectionGranularity = YES;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    [self.view addSubview:self.webView];
}
- (void) reloadData{
    @try {
        NSURL *url = [NSURL URLWithString:self.urlStr];
        if (NULL == url) {
            @throw [NSException exceptionWithName:@"Error" reason:[NSString stringWithFormat:@"urlst 异常:%@",self.urlStr] userInfo:NULL];
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        if (NULL == request) {
            @throw [NSException exceptionWithName:@"Error" reason:[NSString stringWithFormat:@"创建请求异常 异常:%@",self.urlStr] userInfo:NULL];
        }
        [self.webView loadRequest:request];
    } @catch (NSException *exception) {
        [self showAlert:exception.reason handler:NULL];
    } @finally {
        
    }
}

#pragma mark - JS 回调
/// JS 回调函数
/// - Parameters:
///   - name: 执行函数名称
///   - info: 返回内容
- (void) callBackJSWithName:(NSString *)name Info:(NSDictionary *)info{
    if (NULL == info) {
        return [self callBackJSWithName:name infoStr:@"{}"];
    }
    else {
        
    }
    NSError *error = NULL;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
    if (NULL == jsonData) {
        return [self callBackJSWithName:name infoStr:@"{}"];
    }
    else {
        
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (NULL == jsonString) {
        return [self callBackJSWithName:name infoStr:@"{}"];
    }
    else {
        return [self callBackJSWithName:name infoStr:jsonString];
    }
}
/// JS 回调函数
/// - Parameters:
///   - name: 执行函数名称
///   - infoStr: 执行结果JSON字符串
- (void) callBackJSWithName:(NSString *)name infoStr:(NSString *)infoStr{
    NSString *jsString = [NSString stringWithFormat:@"appCallBack('%@','%@')",name,[infoStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]];
    [self.webView evaluateJavaScript:jsString completionHandler:nil];
}

- (void) calljsWithResultJSON:(NSString *)resultJson{
    NSString *jsString = [NSString stringWithFormat:@"calljs('%@')",[resultJson stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]];
    [self.webView evaluateJavaScript:jsString completionHandler:nil];
}

- (void) calljsWithResultDict:(NSDictionary *)resultDict{
    if (NULL == resultDict) {
        return [self calljsWithResultJSON:@"{}"];
    }
    else {
        
    }
    NSError *error = NULL;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resultDict options:NSJSONWritingPrettyPrinted error:&error];
    if (NULL == jsonData) {
        return [self calljsWithResultJSON:@"{}"];
    }
    else {
        
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (NULL == jsonString) {
        return [self calljsWithResultJSON:@"{}"];
    }
    else {
        return [self calljsWithResultJSON:jsonString];
    }
}

#pragma mark - JS API
/// 打开默认浏览器
/// - Parameter urlStr: 目标地址
- (void) jsCallBrowser:(NSString *)urlStr{
    if (NULL == urlStr || ![urlStr isKindOfClass:[NSString class]] || [urlStr length] < 1){
        [self calljsWithResultDict:@{
            @"code":@"10001",
            @"msg":@"URL为空"
        }];
        return;
    }
    else {
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"url.scheme:%@",url.scheme);
    if (NULL == url){
        [self calljsWithResultDict:@{
            @"code":@"10001",
            @"msg":@"URL错误"
        }];
        return;
    }
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            if(success){
                [self calljsWithResultDict:@{
                    @"code":@"1000",
                    @"msg":@"成功"
                }];
            }
            else {
                [self calljsWithResultDict:@{
                    @"code":@"1000",
                    @"msg":@"APP调用失败"
                }];
            }
        }];
    }
    else {
        [self calljsWithResultDict:@{
            @"code":@"10001",
            @"msg":@"URL错误"
        }];
    }
}
#pragma mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if (@"jsCallBrowser".hash == message.name.hash) {
        [self jsCallBrowser:message.body];
    }
}

@end
