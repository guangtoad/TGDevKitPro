//
//  ELCSystemPermissionModel.h
//  smartGLink_cn
//
//  Created by toad on 2022/01/13.
//
//  e-LC 系统隐私权限模型

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

/// 隐私权限授权类型
typedef NS_ENUM(NSInteger, ElcPermissionType) {
    ElcPermissionTypeUnknown = 0,                       /// 未知
    ElcPermissionTypeNotification,                      /// 通知
    ElcPermissionTypeContacts,                          /// 通讯录
    ElcPermissionTypeBluetooth,                         /// 蓝牙
    ElcPermissionTypeLocation,                          /// 位置
    ElcPermissionTypePhotoLibrary,                      /// 相册
    ElcPermissionTypeCamera,                            /// 相机
    ElcPermissionTypeFaceID,                            /// 面部识别
    ElcPermissionTypeMicrophone,                        /// 麦克风
    ElcPermissionTypeReminders,                         /// 时间提醒
};

/// 隐私权限授权状态
typedef NS_ENUM(NSInteger, ElcPermissionStatus) {
    ElcPermissionStatusUnknown = 0,                     /// 未知
    ElcPermissionStatusNotDetermined,                   /// 未设置
    ElcPermissionStatusDenied,                          /// 拒绝
    ElcPermissionStatusRestricted,                      /// 受限制
    ElcPermissionStatusAuthorized                       /// 已授权
};

@interface ELCSystemPermissionModel : NSObject

/// 通知权限
@property (nonatomic,assign) ElcPermissionStatus permissionStatusNotification;
/// 通讯录
@property (nonatomic,assign) ElcPermissionStatus permissionStatusContacts;
/// 蓝牙
@property (nonatomic,assign) ElcPermissionStatus permissionStatusBluetooth;
/// 位置
@property (nonatomic,assign) ElcPermissionStatus permissionStatusLocation;
/// 相册
@property (nonatomic,assign) ElcPermissionStatus permissionStatusPhotoLibrary;
/// 相机
@property (nonatomic,assign) ElcPermissionStatus permissionStatusCamera;
/// 面容
@property (nonatomic,assign) ElcPermissionStatus permissionStatusFaceID;
/// 麦克风
@property (nonatomic,assign) ElcPermissionStatus permissionStatusMicrophone;
/// 事件提醒
@property (nonatomic,assign) ElcPermissionStatus permissionStatusReminders;


/// 通知权限状态
@property (nonatomic,assign) UNAuthorizationStatus authorizationStatusNotification;

/// 定位权限状态
@property (nonatomic,assign) CLAuthorizationStatus authorizationStatusLocation;

/// 通讯录权限状态
@property (nonatomic,assign) CNAuthorizationStatus authorizationStatusContacts;

/// 蓝牙权限状态
@property (nonatomic,assign) CBManagerState authorizationStatusBluetooth;

/// 通知
@property (nonatomic,strong) UNNotificationSettings *notificationSettings;

@property (nonatomic,assign) AVAuthorizationStatus authorizationStatusForMediaTypeAVMediaTypeVideo;

@end

NS_ASSUME_NONNULL_END
