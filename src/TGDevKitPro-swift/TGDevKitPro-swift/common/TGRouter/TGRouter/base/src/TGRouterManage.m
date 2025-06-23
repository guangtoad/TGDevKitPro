//
//  TGRouterManage.m
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGRouterManage.h"

@interface TGRouterManage ()

@property (nonatomic,strong) NSDictionary<NSString *,TGRouterHandler *> *handlers;

@end

@implementation TGRouterManage

static TGRouterManage *__singleton = nil;

+ (instancetype) shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        __singleton = [[self alloc] init] ;
    }) ;
    return __singleton;
}
/**覆盖该方法主要确保当用户通过[[Singleton alloc] init]创建对象时对象的唯一性，alloc方法会调用该方法，只不过zone参数默认为nil，因该类覆盖了allocWithZone方法，所以只能通过其父类分配内存，即[super allocWithZone:zone]
 */
+ (id) allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(__singleton == nil)
        {
            __singleton = [super allocWithZone:zone];
        }
    });
    return __singleton;
}

- (instancetype) init{
    if(self = [super init]) {
    }
    return self;
}
//覆盖该方法主要确保当用户通过copy方法产生对象时对象的唯一性
- (id) copy{
    return self;
}
//覆盖该方法主要确保当用户通过mutableCopy方法产生对象时对象的唯一性
- (id) mutableCopy{
    return self;
}

+ (TGRouterManage *) defaultManager{
    return [self shareInstance];
}

- (BOOL) canOpenURL:(NSURL * __nullable)URL{
    BOOL result = false;
    return result;
}

- (BOOL) canOpenURLStr:(NSString * __nullable)urlStr{
    return [self canOpenURL:[NSURL URLWithString:urlStr]];
}

- (BOOL) openURL:(NSURL *)URL headers:(NSDictionary *)headers params:(NSDictionary<NSString *,id> *)params body:(id)body{
    
    BOOL result = false;
    if ([self canOpenURL:URL]) {
        
    }
    return result;
}

- (BOOL) openURL:(NSURL * __nullable)URL{
    return [self openURL:URL headers:nil params:nil body:nil];
}

@end

