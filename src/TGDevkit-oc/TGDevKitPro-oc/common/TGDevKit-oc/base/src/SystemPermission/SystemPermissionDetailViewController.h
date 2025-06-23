//
//  SystemPermissionDetailViewController.h
//  smartGLink_cn
//
//  Created by toad on 2022/01/13.
//
//  系统权限说明页面

#import <UIKit/UIKit.h>
#import "ELCSystemPermissionModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 系统权限说明页面
@interface SystemPermissionDetailViewController : UIViewController

/// 权限类型
@property (nonatomic,assign) ElcPermissionType permissionType;

@end

NS_ASSUME_NONNULL_END
