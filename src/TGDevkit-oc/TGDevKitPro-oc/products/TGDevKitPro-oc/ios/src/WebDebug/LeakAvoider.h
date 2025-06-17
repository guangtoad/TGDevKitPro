//
//  LeakAvoider.h
//  AIoTSuperApp
//
//  Created by 周力 on 2022/4/27.
//

#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeakAvoider : NSObject<WKScriptMessageHandler>

- (instancetype)initWithMessageHandler:(id <WKScriptMessageHandler>)messageHander;

@end

NS_ASSUME_NONNULL_END
