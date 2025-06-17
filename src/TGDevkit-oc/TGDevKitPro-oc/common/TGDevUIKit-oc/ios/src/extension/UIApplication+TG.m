

//
//  UIApplication+TG.m
//  TGObj
//
//  Created by toad on 15/9/21.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "UIApplication+TG.h"

static NSString *APP_ID = nil;
@implementation UIApplication (TG)

+ (void) setAppId:(NSString *)appid{
    if (APP_ID != nil) {
        APP_ID = nil;
    }
//    APP_ID = TGCopy(appid);
}
+ (NSString *) appid{
    return APP_ID;
}
- (NSString *) lookupUrl{
    NSString *appid = [[self class] appid];
    return [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
}
- (NSDictionary *) getInfoByItunes{
    
    NSString *URL = [self lookupUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = nil;

    if (@available(iOS 9.0,*)){
    }
    else {
        recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    }



    NSLog(@"recervedData:%@",recervedData);
    if (error != nil) {
        return nil;
    }
    else {
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingAllowFragments error:&error];
        NSString *resultCount = [jsonObject objectForKey:@"resultCount"];
        UIApplication *app = [UIApplication sharedApplication];
        
        if (resultCount != nil && [resultCount intValue] == 0) {
            NSDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[app BundleVersion] forKey:@"version"];
        }
        NSArray *array = [jsonObject objectForKey:@"results"];
        if ([array count] < 1) {
            return nil;
        }
        else {
            return [array objectAtIndex:0];
        }
    }
    return nil;
}

- (NSDictionary *) infoDictionary{
    return [[NSBundle mainBundle] infoDictionary];
}
- (NSString *) BundleVersion{
    return [[self infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void) autoAddRunNumber{
    NSInteger runNumber = [[self class] runNumber] + 1;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:runNumber forKey:@"Number_Of_Starts"];
    [userDefaults synchronize];
    return;
}
+ (NSInteger) runNumber{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"Number_Of_Starts"];
}
+ (BOOL) isFirstStart{
    return [self runNumber] < 1;
}
//- (NSDictionary *) infoDictionary;
@end

/**
 UIAppliction 扩展
 */
@implementation UIApplication (TG_info)

static NSString *APP_ID = nil;

/**
 获取app info
 
 @return info Dictionary
 */
+ (NSDictionary *) infoDictionary{
    return [[NSBundle mainBundle] infoDictionary];
}
/**
 获取 app version
 
 @return app version
 */
+ (NSString *) shortVersion{
    return [[self infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
/**
 获取 app build version
 
 @return app build version
 */
+ (NSString *) buildVersion{
    return [[self infoDictionary] objectForKey:@"CFBundleVersion"];
}
/**
 获取 app bundle id
 
 @return app bundle id
 */
+ (NSString *) bundleIdentifier{
    return [[self infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
/**
 获取app document 路径
 
 @return document 路径
 */
+ (NSString *) documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *) appid{
    return APP_ID;
}
- (NSString *) lookupUrl{
    NSString *appid = [[self class] appid];
    return [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
}
- (NSDictionary *) getItunesInfo{
//    
////    [request setURL:[NSURL URLWithString:URL]];
////    [request setHTTPMethod:@"POST"];
//    NSURLResponse *res ;
////    res.
//    NSURL *url = [NSURL URLWithString:@""];
//    NSURLSession *session = [[NSURLSession alloc] init];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
////        switch (response.statusCode) {
////            case <#constant#>:
////                <#statements#>
////                break;
////
////            default:
////                break;
////        }
//        if (!error) {
//            
//        }
//    }];
//    [dataTask resume];
//    
//    
//    NSHTTPURLResponse *urlResponse = nil;
//    NSError *error = nil;
//    [session dataTaskWithURL:[NSURL]]
//    
//    NSURLSessionDataTask *task = [[[NSURLSession alloc] init] dataTaskWithURL:<#(nonnull NSURL *)#> completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//    }]
////    [[[NSURLSession alloc] init] dataTaskWithURL:<#(nonnull NSURL *)#> completionHandler:<#^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)completionHandler#>]
////    [NSURLSession dataTaskWithReq]
//    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//    NSLog(@"recervedData:%@",recervedData);
//    if (error != nil) {
//        return nil;
//    }
//    else {
//        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingAllowFragments error:&error];
//        NSString *resultCount = [jsonObject objectForKey:@"resultCount"];
//        //        UIApplication *app = [UIApplication sharedApplication];
//        
//        if (resultCount != nil && [resultCount intValue] == 0) {
//            NSDictionary *dic = [[NSMutableDictionary alloc] init];
//            [dic setValue:[UIApplication buildVersion] forKey:@"version"];
//        }
//        NSArray *array = [jsonObject objectForKey:@"results"];
//        if ([array count] < 1) {
//            return nil;
//        }
//        else {
//            return [array objectAtIndex:0];
//        }
//    }
    return nil;
}

@end


/**
 应用信息
 */
@implementation TGApplictionData

+ (id) unarchiveObjectWithFile:(NSString *)path{
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if (!error) {
        return nil;
    }
    typeof([self class]) obj = nil;
    if (@available(iOS 11.0,*)){
        obj = [NSKeyedUnarchiver unarchivedObjectOfClass:[self class] fromData:data error:&error];
        if (!error) {
            return nil;
        }
    }
    return obj;
}
#pragma mark - 单例
static TGApplictionData *__instance;

+ (TGApplictionData *) getInstance{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __instance = [[self alloc] init];
        
    });
    return __instance;
}
#pragma mark - 懒加载
- (NSString *) version{
    if (!_version) {
        _version = [UIApplication shortVersion];
    }
    return _version;
}
- (NSString *) buildVersion{
    if (!_buildVersion) {
        _buildVersion = [UIApplication buildVersion];
    }
    return _buildVersion;
}

- (NSString *) bundleIdentifier{
    if (!_bundleIdentifier) {
        _bundleIdentifier = [UIApplication bundleIdentifier];
    }
    return _bundleIdentifier;
}
#pragma mark - 初始化

/**
 初始化
 
 @return self
 */
- (id) init{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - NSCoding

/**
 NSCoding 解码
 
 @param aDecoder adecoder
 @return self
 */
- (id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [self init]) {
        self.bundleIdentifier = [aDecoder decodeObjectForKey:@"bundleIdentifier"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        self.buildVersion = [aDecoder decodeObjectForKey:@"buildVersion"];
    }
    return self;
}
/**
 NSCodeing 编码
 
 @param aCoder aCoder
 */
- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder setValue:self.bundleIdentifier forKey:@"bundleIdentifier"];
    [aCoder setValue:self.version forKey:@"version"];
    [aCoder setValue:self.buildVersion forKey:@"buildVersion"];
}

@end