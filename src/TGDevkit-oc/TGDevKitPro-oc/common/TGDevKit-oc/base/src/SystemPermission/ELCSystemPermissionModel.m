//
//  ELCSystemPermissionModel.m
//  smartGLink_cn
//
//  Created by toad on 2022/01/13.
//
//  e-LC 系统隐私权限模型

#import "ELCSystemPermissionModel.h"

@implementation ELCSystemPermissionModel

- (instancetype) init{
    
    if (self = [super init]) {
        /// 通知权限
        self.permissionStatusNotification = ElcPermissionStatusUnknown;
        /// 通讯录
        self.permissionStatusContacts = ElcPermissionStatusUnknown;
        /// 蓝牙
        self.permissionStatusBluetooth = ElcPermissionStatusUnknown;
        /// 位置
        self.permissionStatusLocation = ElcPermissionStatusUnknown;
        /// 相册
        self.permissionStatusPhotoLibrary = ElcPermissionStatusUnknown;
        /// 相机
        self.permissionStatusCamera = ElcPermissionStatusUnknown;
        /// 面容
        self.permissionStatusFaceID = ElcPermissionStatusUnknown;
        /// 麦克风
        self.permissionStatusMicrophone = ElcPermissionStatusUnknown;
        /// 事件提醒
        self.permissionStatusReminders = ElcPermissionStatusUnknown;
    }
    
    return self;
}

- (void) setNotificationSettings:(UNNotificationSettings *)notificationSettings{
    self.notificationSettings = notificationSettings;
    [self setAuthorizationStatusNotification:self.notificationSettings.authorizationStatus];
}

@end
