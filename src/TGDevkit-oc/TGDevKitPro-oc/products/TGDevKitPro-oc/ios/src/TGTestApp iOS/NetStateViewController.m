//
//  NetStateViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/29.
//
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreFoundation/CoreFoundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "NetStateViewController.h"


@interface NetStateViewController ()<CTTelephonyNetworkInfoDelegate>{
    SCNetworkReachabilityRef _reachabilityRef;
}
@property (nonatomic, strong) CTTelephonyNetworkInfo *networkInfo;
@property (nonatomic,strong) IBOutlet UITextView *textView;
@end

@implementation NetStateViewController

- (CTTelephonyNetworkInfo *)networkInfo{
    if (!_networkInfo) {
        _networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        if (@available(iOS 13.0, *)) {
            _networkInfo.delegate = self;
        } else {
            // Fallback on earlier versions
        }
    }
    return _networkInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(reload)];
    self.navigationItem.rightBarButtonItem = rigthItem;
}

- (void) reload{
    self.textView.text = @"";
    [self getNetState];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getNetState];
}

- (void) addTextWithString:(NSString *)format, ... {
    va_list arg_list;
    va_start (arg_list, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:arg_list];
    va_end(arg_list);
    self.textView.text = [self.textView.text stringByAppendingFormat:@"\n%@",string];
    
}

- (void) getNetState{
    
    
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags)) {
        [self addTextWithString:@"SCNetworkReachabilityGetFlags:%ld",flags];
    }
    else {
        [self addTextWithString:@"SCNetworkReachabilityGetFlags:false"];
    }
        
    [self addTextWithString:@"serviceCurrentRadioAccessTechnology:"];
    for (NSString *key in [self.networkInfo.serviceCurrentRadioAccessTechnology allKeys]) {
        [self addTextWithString:@"%@:%@",key,self.networkInfo.serviceCurrentRadioAccessTechnology[key]];
    }
    
    [self addTextWithString:@"serviceSubscriberCellularProviders:"];
        
    for (NSString *key in [self.networkInfo.serviceSubscriberCellularProviders allKeys]) {
        [self addTextWithString:@"%@:%@",key,self.networkInfo.serviceSubscriberCellularProviders[key]];
    }
    NSString *state = @"";
    UIApplication *app = [UIApplication sharedApplication];
//    //iPhone X
    if ([[app valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        id children = [[[[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        for (UIView *view in children) {
            for (id child in view.subviews) {
                if ([child isKindOfClass:NSClassFromString(@"_UIStatusBarImageView")]) {
                    state = @"airPlane";
                }
            }
        }
    }
    else {
        //其他机型
        id children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarAirplaneModeItemView")]) {
                state = @"airPlane";
            }
        }
    }
    [self addTextWithString:@"UI State"];
    [self addTextWithString:@"state:%@",state];
//    NSLog(@"Initial cell connection: %@;\n %@", self.networkInfo.currentRadioAccessTechnology,self.networkInfo.subscriberCellularProvider);
    NSURL *url = NULL;
//    url.scheme;
//    url.query
}


#pragma mark - CTTelephonyNetworkInfoDelegate
- (void)dataServiceIdentifierDidChange:(NSString *)identifier{
    [self addTextWithString:@"dataServiceIdentifierDidChange:%@",identifier];
}
@end
