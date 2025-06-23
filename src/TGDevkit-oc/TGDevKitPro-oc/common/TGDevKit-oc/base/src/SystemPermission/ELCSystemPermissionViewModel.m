//
//  ELCSystemPermissionViewModel.m
//  smartGLink_cn
//
//  Created by toad on 2022/01/13.
//
//  e-LC 系统隐私权限VM

#import "ELCSystemPermissionViewModel.h"

@interface ELCSystemPermissionViewModel ()

@end

@implementation ELCSystemPermissionViewModel

/// 获取单例
+ (ELCSystemPermissionModel *) getInstancePermissionModel{
    static ELCSystemPermissionModel *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/// 定位权限状态获取
- (void) reloadLocationAuthorizationStatus{
}
/// 通知权限状态获取
- (void) reloadNotificationAuthorizationStatus{
}
/// 通讯录权限状态获取
- (void) reloadContactsAuthorizationStatus{
}
/// 蓝牙权限状态获取
- (void) reloadBluetoothAuthorizationStatus{
}

/// 通知权限
- (void) reloadNotificationPermissionStatus{
    ELCSystemPermissionModel *model = [[self class] getInstancePermissionModel];
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        [model setNotificationSettings:settings];
    }];
}
/// 通讯录
- (void) reloadContactsPermissionStatus{
    ELCSystemPermissionModel *model = [[self class] getInstancePermissionModel];
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    model.authorizationStatusContacts = status;
}
/// 蓝牙
- (void) reloadBluetoothPermissionStatus{
    ELCSystemPermissionModel *model = [[self class] getInstancePermissionModel];
    CBCentralManager *manager = [[CBCentralManager alloc] init];
    model.authorizationStatusBluetooth = manager.state;
}
/// 位置
- (void) reloadLocationPermissionStatus{
    ELCSystemPermissionModel *model = [[self class] getInstancePermissionModel];
    ElcPermissionStatus status = ElcPermissionStatusUnknown;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    CLAuthorizationStatus authorizationStatus = [locationManager authorizationStatus];
    switch (authorizationStatus) {
            // 未设置
        case kCLAuthorizationStatusNotDetermined:
            status = ElcPermissionStatusNotDetermined;
            break;
            // 受限
        case kCLAuthorizationStatusRestricted:
            status = ElcPermissionStatusRestricted;
            break;
            // 拒绝
        case kCLAuthorizationStatusDenied:
            status = ElcPermissionStatusDenied;
            break;
            // 所有时间
        case kCLAuthorizationStatusAuthorizedAlways:
            status = ElcPermissionStatusAuthorized;
            break;
            // 使用时可用
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            status = ElcPermissionStatusAuthorized;
            break;
        default:
            break;
    }
    model.permissionStatusLocation = status;
}
/// 相册
- (void) reloadPhotoLibraryPermissionStatus{
    
}
/// 相机
- (void) reloadCameraPermissionStatus{
    
    ELCSystemPermissionModel *model = [[self class] getInstancePermissionModel];
    ElcPermissionStatus status = ElcPermissionStatusUnknown;
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
            // 未设置
        case AVAuthorizationStatusNotDetermined:{
            status = ElcPermissionStatusNotDetermined;
        }
            break;
            // 受限制
        case AVAuthorizationStatusRestricted:{
            status = ElcPermissionStatusRestricted;
        }
            break;
            // 已拒绝
        case AVAuthorizationStatusDenied:{
            status = ElcPermissionStatusDenied;
        }
            break;
            // 已授权
        case AVAuthorizationStatusAuthorized:{
            status = ElcPermissionStatusAuthorized;
        }
            break;
        default:
            break;
    }
    model.permissionStatusCamera = status;
}
/// 面容
- (void) reloadFaceIDPermissionStatus{
    
}
/// 麦克风
- (void) reloadMicrophonePermissionStatus{
    
}
/// 事件提醒
- (void) reloadRemindersPermissionStatus{
    
}
/// 重新获取权限信息
- (void) reloadPermissionStatus{
    
}

///// 重新加载权限状态
//- (void) reloadPermissionStatusWithType:(ElcSytempPermissionType)type{
//
//}}

@end
