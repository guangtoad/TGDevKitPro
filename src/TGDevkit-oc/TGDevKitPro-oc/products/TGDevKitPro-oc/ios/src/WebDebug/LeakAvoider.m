//
//  LeakAvoider.m
//  AIoTSuperApp
//
//  Created by 周力 on 2022/4/27.
//

#import "LeakAvoider.h"


@interface LeakAvoider ()

@property (nonatomic, weak) id <WKScriptMessageHandler> scriptDelegate;

@end
@implementation LeakAvoider

- (instancetype)initWithMessageHandler:(id <WKScriptMessageHandler>)messageHander {
    if (self = [super init]) {
        _scriptDelegate = messageHander;
    }
    return self;
}
 
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.scriptDelegate && [self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
