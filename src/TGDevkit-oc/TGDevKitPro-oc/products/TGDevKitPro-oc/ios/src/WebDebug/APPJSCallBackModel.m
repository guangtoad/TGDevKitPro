//
//  APPJSCallBackModel.m
//  TGDevelopToolsApp
//
//  Created by toad on 2024/1/12.
//

#import "APPJSCallBackModel.h"

@implementation APPJSCallBackModel

- (id) initWithCode:(NSString *)code msg:(NSString *)msg{
    if (self = [super init]) {
        self.code = code;
        self.msg = msg;
    }
    return self;
}

+ (APPJSCallBackModel *) modelWithCode:(NSString *)code msg:(NSString *)msg{
    return [[APPJSCallBackModel alloc] initWithCode:code msg:msg];
}

@end
