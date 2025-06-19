//
//  TGLogUIKit.m
//  TGLog
//
//  Created by toad on 2021/08/31.
//

#import "TGLogUIKit.h"

@implementation TGLogUIKit

- (void) encodeWithCoder:(NSCoder *)coder{
    [coder encodeBool:self.enableDebug forKey:@"OFFON_DEBUG"];
    [coder encodeBool:self.enableToast forKey:@"OFFON_TOAST"];
    [coder encodeBool:self.enableFloatView forKey:@"OFFON_FLOATVIEW"];;
}

- (id) initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        self.enableDebug = [coder decodeBoolForKey:@"OFFON_DEBUG"];
        self.enableToast = [coder decodeBoolForKey:@"OFFON_TOAST"];
        self.enableFloatView = [coder decodeBoolForKey:@"OFFON_FLOATVIEW"];
    }
    return self;;
}

/// 静态单例
static TGLogUIKit *instance;


+ (instancetype) initUIKit{
    id instance = [self shareInstance];
    [instance initUIKit];
    return instance;
}

- (void) initUIKit{
    [TGLoggerManager setFormaterBlock:^NSString * _Nullable(NSString * _Nullable tag, TGLogLevel level, NSDate * _Nullable date, NSString * _Nullable message) {
        
        return NULL;
    }];
}

/// 获取单例
+ (instancetype) shareInstance {
    @synchronized(self) {
        if (instance == nil) {
            // 生成默认设置
            instance = [[TGLogUIKit alloc] init];
        }
    }
    return instance;
}


+ (void) initaa{
    [TGLoggerManager setFormaterBlock:^NSString * _Nullable(NSString * _Nullable tag, TGLogLevel level, NSDate * _Nullable date, NSString * _Nullable message) {
        
        return NULL;
    }];
}

+ (BOOL) openSheetWithController:(__kindof TGViewController * _Nullable)viewController{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"日志" message:@"功能" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alert addAction:actionCancel];
    
    UIAlertAction *actionClaer = [UIAlertAction actionWithTitle:@"Claer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[self class] claerWithController:viewController];
    }];
    [alert addAction:actionClaer];
    
    UIAlertAction *actionExport = [UIAlertAction actionWithTitle:@"Export" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actionExport];
    
    [viewController presentViewController:alert animated:true completion:nil];
    return true;
}

//
//+ (BOOL) openExportSheetWithController:(__kindof TGViewController * _Nullable)viewController{
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"日志" message:@"功能" preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alert addAction:actionCancel];
//
//    UIAlertAction *actionClaer = [UIAlertAction actionWithTitle:@"Claer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [[self class] claerWithController:viewController];
//    }];
//    [alert addAction:actionClaer];
//
//    UIAlertAction *actionExport = [UIAlertAction actionWithTitle:@"Export" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alert addAction:actionExport];
//
//    [viewController presentViewController:alert animated:true completion:nil];
//    return true;
//}

+ (BOOL) openSheet{
    if (![NSThread isMainThread]) {
        return false;
    }
    UIWindow *keyWindow = NULL;
    
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                for (UIWindow *window in windowScene.windows)
                {
                    if (window.isKeyWindow)
                    {
                        keyWindow = window;
                        break;
                    }
                }
            }
        }
    }
    else
    {
//        keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    if (keyWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                keyWindow = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[keyWindow subviews] objectAtIndex:0];
    TGViewController *controller = NULL;
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        controller = nextResponder;
    }
    else {
        controller = keyWindow.rootViewController;
    }
    return [self openSheetWithController:controller];
}

+ (BOOL) clearIsConfirm:(BOOL)isConfirm{
    if (isConfirm) {
        
    }
    else {
        
    }
    return true;
}

+ (BOOL) clearWithController:(__kindof TGViewController * _Nullable)viewController isConfirm:(BOOL)isConfirm{
    if (isConfirm) {
        return [TGLoggerManager clearAll];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log" message:@"功能" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self clearWithController:NULL isConfirm:true];
           
        }];
        [alert addAction:actionConfirm];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
        }];
        [alert addAction:actionCancel];
        [viewController showViewController:alert sender:alert];
        return true;
    }
}

+ (BOOL) claerWithController:(__kindof TGViewController * _Nullable)viewController{
    return [self clearWithController:viewController isConfirm:false];
}

+ (__kindof TGViewController * _Nullable) getRootViewController{
    
    NSBundle *bundle = NULL;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TGLogUIKit" ofType:@"bundle"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        bundle = [NSBundle bundleWithPath:path];
    }
    else {
        path = [[NSBundle mainBundle] pathForResource:@"TGLogUIKit" ofType:@"storyboardc"];
        if (![fileManager fileExistsAtPath:path]) {
        }
        else {
            bundle = [NSBundle mainBundle];
        }
    }
    if (NULL != bundle) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TGLogUIKit" bundle:bundle];
        return storyboard.instantiateInitialViewController;
    }
    
    return NULL;
}

+ (__kindof TGViewController * _Nullable) openLogViewController{
    TGLogFetchViewController *viewController = [self getRootViewController];
    return viewController;
}

+ (BOOL) exportLogFile{
    if (![NSThread isMainThread]) {
        return false;
    }
    UIWindow *keyWindow = NULL;
    
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                for (UIWindow *window in windowScene.windows)
                {
                    if (window.isKeyWindow)
                    {
                        keyWindow = window;
                        break;
                    }
                }
            }
        }
    }
    else
    {
//        keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    if (keyWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                keyWindow = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[keyWindow subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    UIViewController *controller = NULL;
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        controller = nextResponder;
    }
    else {
        controller = keyWindow.rootViewController;
    }
    return [self exportLogFileWithViewController:controller];
}

+ (BOOL) exportLogFileWithViewController:(__kindof UIViewController * _Nonnull)viewController{
    BOOL result = false;
//    UIAlertController *alert = []
    return result;
}

+ (void) showToastWith:(NSString *)txtStr{
    TGLogToast *toast = [[TGLogToast alloc] init];
    [toast showWith:txtStr];
}

@end
