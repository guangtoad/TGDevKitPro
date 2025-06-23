//
//  AppDelegate.m
//  TGTestApp iOS
//
//  Created by toad on 2022/06/01.
//

#import "AppDelegate.h"
#import "AppUtility.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Map/BMKMapVersion.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

//#import "BNaviService.h"
//#import <Realm/Realm.h>
//#import <TGLoger_iOS/TGLoggerManager.h>
//#import "BMKMapManager.h"
@interface AppDelegate ()<BMKGeneralDelegate,BMKLocationAuthDelegate>

@end

@implementation AppDelegate

@synthesize window = _window;
// Toad Edit End */
// EDIT00016 End
// EDIT111301 Begin
// Toad Edit[改修] 20191021 Begin---------->/*

- (void) setupElcAppearance{
}
- (void) setupLog{
    
//    [TGLoggerManager initDefaule];
//    [TGLoggerManager pringSetting];
//    [TGLoggerManager setFormaterBlock:^NSString * _Nullable(NSString * _Nullable tag, TGLogLevel level, NSDate * _Nullable date, NSString * _Nullable message) {
//        return NULL;
//    }];
//    [TGLoggerManager tg_logDebug:@"Test loage"];
}
// Toad Edit End */
// EDIT111301 End
- (NSString *) bundleID{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info objectForKey:@"CFBundleIdentifier"];
}

//BMKMapManager* _mapManager;
///// 启动百度导航
- (void) setupBaiduSDK{

    NSString *bundleID = [self bundleID];

    NSString *Baidu_Map_ApiKey = nil;
    NSString *Baidu_TTS_APPID = nil;
    NSString *Baidu_TTS_APIKey = nil;
    NSString *Baidu_TTS_secretKey = nil;

    if ([@"com.toad.obj1" isEqualToString:bundleID]) {
        Baidu_Map_ApiKey = @"6mgooHxLK9fITiEmlaGUmMaORU9tBR0c";
        Baidu_TTS_APPID = @"11700909";
        Baidu_TTS_APIKey = @"ZZXP7pUGLXQFGH1MftLULoTi";
        Baidu_TTS_secretKey = @"DUaC8thaWnNoQnfOIZO9fj6HGZi0izBe";
    }

    else if ([@"com.syqb.obj1" isEqualToString:bundleID]) {
        Baidu_Map_ApiKey = @"kaFzNCj0GkN3zl9xaeUw0KGc0NM1k6bf";
        Baidu_TTS_APPID = @"11541006";
        Baidu_TTS_APIKey = @"5HqKIQA3pfeLkfGGjFza0tt5";
        Baidu_TTS_secretKey = @ "Zf8Xa4nHXH39Gv9uvqWuMf2AZjrdLt6K";
    }
    else if ([@"com.syqb.elc.stub" isEqualToString:bundleID]) {
         Baidu_Map_ApiKey = @"IPRhI7aW9PaiUH8Q5LWACzfGGCMaOP8Z";
        Baidu_TTS_APPID = @"26066407";
        Baidu_TTS_APIKey = @"iwZRIZDl2kWkDqghmLrzv9tP";
        Baidu_TTS_secretKey = @"9cXNim4eOy9pThhm5HmKEk1Zp9vxQ7Pl";
    }
    else {
        Baidu_Map_ApiKey = @"b3AEZ7dTTlkoxVZKnf30q7KyXmZkm0hf";
        Baidu_TTS_APPID = @"11700909";
        Baidu_TTS_APIKey = @"ZZXP7pUGLXQFGH1MftLULoTi";
        Baidu_TTS_secretKey = @"DUaC8thaWnNoQnfOIZO9fj6HGZi0izBe";
    }
    // 要使用百度地图，请先启动BaiduMapManager
    // EDITXC135001 BEGIN
    // Xcode13升级 第三方库引入对应 2022/04/27 START Toad
    // 百度地图SDK升级
    //    _mapManager = [[BMKMapManager alloc] init];
    BMKMapManager * _mapManager = NULL;
    _mapManager = [[BMKMapManager alloc] init];
    // Xcode13升级 第三方库引入对应 2022/04/27 END Toad
    // EDITXC135001 END

    /**
     *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:Baidu_Map_ApiKey authDelegate:self];
    // 定位SDK隐私权限授权
    [[BMKLocationAuth sharedInstance] setAgreePrivacy:YES];
    // 地图SDK隐私权限授权
    [BMKMapManager setAgreePrivacy:YES];
    // 导航SDK隐私权限授权
//    [BNaviService setAgreePrivacy:YES];
//    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_GPS]) {
////        TGLog(@"经纬度类型设置成功");
//    } else {
////        TGWarn(@"经纬度类型设置失败");
//    }
    if (![_mapManager start:Baidu_Map_ApiKey generalDelegate:self]) {
//        TGWarn(@"百度地图 manager start 失败!");
    }
    else {
//        TGLog(@"百度地图 manager start 成功!");
    }
//    [BNaviService_Instance initNaviService:nil
//                                   success:^{
////        [BNaviService_Instance authorizeNaviAppKey:Baidu_Map_ApiKey
////                                        completion:^(BOOL suc) {
//////            TGLog(@"authorizeNaviAppKey ret = %d",suc);
////        }];
////        [BNaviService_Instance authorizeTTSAppId:Baidu_TTS_APPID
////                                          apiKey:Baidu_TTS_APIKey
////                                       secretKey:Baidu_TTS_secretKey
////                                      completion:^(BOOL suc) {
//////            TGLog(@"authorizeTTS ret = %d",suc);
////        }];
//        //            [BNaviService_Sound setSoundDelegate:self];
//    } fail:^{
////        TGLog(@"initNaviSDK fail");
//    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    INITDEBUGLOGER;
//    [TGLoggerManager tg_logDebug:@"cs"];
//    DEBUGLOG(@"测试日志：");
    [AppUtility setupAppearance];
    // Override point for customization after application launch.
    [self setupBaiduSDK];
    [self setupLog];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
    UIViewController *controller =  mainStoryboard.instantiateInitialViewController;
    if ([controller isKindOfClass:[UITabBarController class]]) {
        self.tabbarController = (UITabBarController *)controller;
    }
    [self.window setRootViewController:controller];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application{
    NSLog(@"%s",__FUNCTION__);
}
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions{
    NSLog(@"%s",__FUNCTION__);
    return true;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"%s",__FUNCTION__);
}
- (void)applicationWillResignActive:(UIApplication *)application{
    NSLog(@"%s",__FUNCTION__);
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    NSLog(@"%s",__FUNCTION__);
    return true;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    NSLog(@"%s",__FUNCTION__);
    return true;
}

#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


#pragma mark - Core Data stack

//@synthesize persistentContainer = _persistentContainer;

//- (NSPersistentContainer *)persistentContainer {
//    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
//    @synchronized (self) {
//        if (_persistentContainer == nil) {
//            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TGTestApp_iOS"];
//            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
//                if (error != nil) {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                    /*
//                     Typical reasons for an error here include:
//                     * The parent directory does not exist, cannot be created, or disallows writing.
//                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                     * The device is out of space.
//                     * The store could not be migrated to the current model version.
//                     Check the error message to determine what the actual problem was.
//                    */
//                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//                    abort();
//                }
//            }];
//        }
//    }
//
//    return _persistentContainer;
//}

#pragma mark - Core Data Saving support

//- (void)saveContext {
//    NSManagedObjectContext *context = self.persistentContainer.viewContext;
//    NSError *error = nil;
//    if ([context hasChanges] && ![context save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//}

@end
