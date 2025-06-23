//
//  UIApplication+TG.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "UIApplication+TG.h"

static NSString *APP_ID = nil;

@implementation UIApplication (TG)

+ (void) setAppId:(NSString *)appid{
    if (APP_ID != nil) {
        APP_ID = nil;
    }
    APP_ID = TGCopy(appid);
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
    
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"recervedData:%@",recervedData);
    if (error != nil) {
        return nil;
    }
    else {
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingAllowFragments error:&error];
        NSString *resultCount = [jsonObject objectForKey:@"resultCount"];
//        UIApplication *app = [UIApplication sharedApplication];
        
        if (resultCount != nil && [resultCount intValue] == 0) {
            NSDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:[UIApplication BundleVersion] forKey:@"version"];
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

+ (NSDictionary *) infoDictionary{
    return [[NSBundle mainBundle] infoDictionary];
}
+ (NSString *) BundleVersion{
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

+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (BOOL) versionCheck{
    NSString *bVersion = [self BundleVersion];
    NSDictionary *infoDic = [self infoDictionary];
    TGLOG(@"bversion:%@",bVersion);
    TGLOGINFO(@"infoDic:%@",infoDic);
    return false;
}

@end
