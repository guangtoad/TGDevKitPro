//
//  AppDelegate.m
//  TGDevKitPro-oc
//
//  Created by toad on 2025/6/11.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void) setupMainController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NULL];
    self.window.rootViewController = storyboard.instantiateInitialViewController;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TGLoggerManager initDefaule];
    [TGLoggerManager pringSetting];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LaunchViewController *controller = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:NULL];
    window.rootViewController = controller;
    [window makeKeyAndVisible];
    [self setWindow:window];
    return YES;
}
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    return true;
}
- (void) applicationWillResignActive:(UIApplication *)application{
}
- (void) applicationDidBecomeActive:(UIApplication *)application{
    if (self.isLoaded){
        
    }
    else {
        MainApplication *mainApp = [MainApplication shareInstance];
        if ([mainApp resourceVerifyAndUploadFile:^(NSString * _Nonnull callBockName, NSDictionary * _Nonnull info, NSError * _Nonnull error) {
            
        } completionHandler:^(NSString * _Nonnull callBockName, NSDictionary * _Nonnull info, NSError * _Nonnull error) {
            self.isLoaded = true;
            [self setupMainController];
        }]) {
            [self setupMainController];
        };
        self.isLoaded = true;
    }
}
- (void) applicationWillTerminate:(UIApplication *)application{
}
- (void) applicationWillEnterForeground:(UIApplication *)application{
}
- (void) applicationDidEnterBackground:(UIApplication *)application{
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *) persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TG_Develop_Tools_iOS"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void) saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
