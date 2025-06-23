//
//  SystemPermissionDetailViewController.m
//  smartGLink_cn
//
//  Created by toad on 2022/01/13.
//
//  系统权限说明页面

#import "SystemPermissionDetailViewController.h"

/// 系统权限说明页面
@interface SystemPermissionDetailViewController ()

@end

/// 系统权限说明页面
@implementation SystemPermissionDetailViewController

/// 获取隐私权限系统设计的路径
/// @param permissionType 隐私类型
- (NSString *) getPermissionSettingURLStringWithType:(ElcPermissionType)permissionType{
    return UIApplicationOpenSettingsURLString;
}

/// 获取隐私权限系统设计的URL
/// @param permissionType 隐私类型
- (NSURL *) getPermissionSettingURLWithType:(ElcPermissionType)permissionType{
    NSString *URLString = [self getPermissionSettingURLStringWithType:permissionType];
    NSURL *url = NULL;
    if (NULL != URLString && [URLString isKindOfClass:[NSString class]] && URLString.length > 0) {
        url = [[NSURL alloc] initWithString:URLString];
    }
    return url;
}

/// 打开系统页面
- (void) openSystemSettingView{
    NSURL *url = [self getPermissionSettingURLWithType:self.permissionType];
    if (NULL != url) {
        [[UIApplication sharedApplication] openURL:url
                                           options:@{
        }
                                 completionHandler:nil];
    }
}

#pragma mark - LifeCycle

/// 视图加载后
- (void) viewDidLoad {
    [super viewDidLoad];
}

/// 视图显示前
/// @param animated 动画
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/// 视图显示后
/// @param animated 动画
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

@end
