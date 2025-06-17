//
//  WebDebugViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "DataSourceViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebDebugViewController : DataSourceViewController

@property (nonatomic,strong) IBOutlet WKWebView *webView;
@property (nonatomic,strong) NSString *urlStr;

@end

NS_ASSUME_NONNULL_END
