//
//  APPJSCallBackModel.h
//  TGDevelopToolsApp
//
//  Created by toad on 2024/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPJSCallBackModel : NSObject

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *msg;

- (id) initWithCode:(NSString *)code msg:(NSString *)msg;
+ (APPJSCallBackModel *) modelWithCode:(NSString *)code msg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
