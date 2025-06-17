//
//  MainApplication.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^MainApplicationCallBackBlock)(NSString *callBockName,NSDictionary *info,NSError * __nullable error);

@interface MainApplication : NSObject

@property (nonatomic,strong) MainApplicationCallBackBlock _uploadCallBack;

+ (MainApplication *)shareInstance;

- (void) registerNotification;

- (BOOL) resourceVerifyAndUploadFile:(MainApplicationCallBackBlock)uploadProgressBlock
                   completionHandler:(MainApplicationCallBackBlock)completionHandler;

@end

NS_ASSUME_NONNULL_END
