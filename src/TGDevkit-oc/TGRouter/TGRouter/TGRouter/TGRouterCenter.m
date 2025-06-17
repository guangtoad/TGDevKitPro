//
//  TGRouterCenter.m
//  TGRouter
//
//  Created by toad on 2019/6/19.
//  Copyright © 2019 toad. All rights reserved.
//

#import "TGRouterCenter.h"

@interface TGRouterCenter ()
@property (nonatomic,strong) NSMutableArray<TGRouterModule *> *modules;
@end

@implementation TGRouterCenter

static TGRouterCenter *__singleton = nil;

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

+ (TGRouterCenter *) defaultCenter{
    return [self shareInstance];
}

- (NSArray<TGRouterModule *> *)modules{
    if (_modules) {
        _modules = [[NSMutableArray alloc] init];
    }
    return _modules;
}

- (void) addRouterModule:(TGRouterModule *)module{
    [self.modules addObject:module];
}

- (BOOL) beginOpen:(NSURL *)url sender:(NSObject *)sender {
//    for (TGRouterModule *module in self.modules) {
////        [module beginRequest:<#(TGRouterRequest *)#> sender:sender];
//    }
//    [self.modules makeObjectsPerformSelector:@selector(beginRequest:sender:) withObject:<#(nullable id)#>]
    return true;
}

@end
