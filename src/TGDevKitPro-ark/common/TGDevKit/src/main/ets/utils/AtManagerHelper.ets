/**
 * @file AtManagerHelper.ets
 * @name
 * @summary 权限助手类
 * @description 该类提供了用于管理和请求应用权限的功能。
 * @author toad
 * @create 2024/10/23
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */

import { abilityAccessCtrl, PermissionRequestResult, Permissions, bundleManager } from '@kit.AbilityKit';

/**
 * AtManagerItem 类表示权限项的状态。
 */
export class AtManagerItem {
  status?: abilityAccessCtrl.GrantStatus; // 权限状态
  permissionNames?: Permissions; // 权限名称
}

/**
 * PermissionResult 类表示权限请求的结果。
 */
@Observed
export class PermissionResult {
  authStatus?: number; // 授权状态
  permissionName?: string; // 权限名称
  dialogShownResult?: boolean; // 是否显示了请求权限的对话框

  /**
   * 设置授权状态
   * @param {number} authStatus - 授权状态
   * @returns {this} - 返回当前实例
   */
  setAuthStatus(authStatus: number) {
    this.authStatus = authStatus;
    return this;
  }

  /**
   * 设置权限名称
   * @param {string} permissionName - 权限名称
   * @returns {this} - 返回当前实例
   */
  setPermissionNames(permissionName: string) {
    this.permissionName = permissionName;
    return this;
  }

  /**
   * 设置对话框显示结果
   * @param {boolean | undefined} dialogShownResult - 对话框显示结果
   * @returns {this} - 返回当前实例
   */
  setDialogShownResult(dialogShownResult?: boolean | undefined) {
    this.dialogShownResult = dialogShownResult;
    return this;
  }
}

/**
 * AtManagerHelper 类提供了权限管理的静态方法。
 */
export class AtManagerHelper {
  /**
   * 检查访问令牌的权限
   * @param {abilityAccessCtrl.AtManager} atManager - 权限管理器实例
   * @param {Permissions} permissionName - 权限名称
   * @param {number} tokenID - 令牌ID
   * @returns {Promise<AtManagerItem>} - 返回权限项的状态
   */
  public static async checkAccessToken(atManager: abilityAccessCtrl.AtManager, permissionName: Permissions,
    tokenID: number): Promise<AtManagerItem> {
    let result: AtManagerItem = {
      permissionNames: permissionName
    };
    try {
      result.status = await atManager.checkAccessToken(tokenID, permissionName); // 检查访问令牌的权限
    }
    catch (error) {
    }
    return result; // 返回权限项状态
  }

  /**
   * 创建权限结果实例
   * @param {string} permissionName - 权限名称
   * @param {number} authStatus - 授权状态
   * @param {boolean} [dialogShownResult] - 对话框显示结果
   * @returns {PermissionResult} - 返回权限结果实例
   */
  public static createPermissionResult(permissionName: string, authStatus: number,
    dialogShownResult?: boolean): PermissionResult {
    return new PermissionResult().setPermissionNames(permissionName)
      .setAuthStatus(authStatus)
      .setDialogShownResult(dialogShownResult);
  }

  /**
   * 检查多个权限
   * @param {Permissions[]} permissions - 权限列表
   * @param {number} [tokenId] - 令牌ID
   * @returns {Promise<Array<PermissionResult>>} - 返回权限结果数组
   */
  public static async checkPermissions(permissions: Permissions[], tokenId?: number): Promise<Array<PermissionResult>> {
    if (undefined == tokenId && null == tokenId) {
      let bundleInfo: bundleManager.BundleInfo =
        bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId; // 获取应用的访问令牌ID
    }
    let result: Array<PermissionResult> = new Array();
    let atManager = abilityAccessCtrl.createAtManager(); // 创建权限管理器实例
    let promiseList: Array<Promise<abilityAccessCtrl.GrantStatus>> = new Array();

    // 检查每个权限的状态
    permissions.forEach((permissionName: Permissions) => {
      let promise = atManager.checkAccessToken(tokenId, permissionName);
      promiseList.push(promise);
    });
    if (promiseList.length > 0) {
      let results = await Promise.all(promiseList); // 等待所有权限检查完成
      results.forEach((grantStatus: abilityAccessCtrl.GrantStatus, index: number) => {
        if (index < permissions.length) {
          let permissionName = permissions[index];
          if (abilityAccessCtrl.GrantStatus.PERMISSION_DENIED == grantStatus) {
            result.push(AtManagerHelper.createPermissionResult(permissionName, -1)); // 权限被拒绝
          }
          else if (abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED == grantStatus) {
            result.push(AtManagerHelper.createPermissionResult(permissionName, 0)); // 权限被授予
          }
          else {
            result.push(AtManagerHelper.createPermissionResult(permissionName, 2)); // 权限检查错误
          }
        }
        else {
        }
      });
    }

    return result; // 返回权限结果数组
  }

  /**
   * 请求用户的权限
   * @param {Context} context - 上下文
   * @param {Array<Permissions>} permissionList - 权限列表
   * @returns {Promise<Array<PermissionResult>>} - 返回权限结果数组
   */
  public static async requestPermissions(context: Context,
    permissionList: Array<Permissions>): Promise<Array<PermissionResult>> {
    let result: Array<PermissionResult> = new Array();
    try {
      let atManager = abilityAccessCtrl.createAtManager(); // 创建权限管理器实例
      let requestResult: PermissionRequestResult = await atManager.requestPermissionsFromUser(context, permissionList);
      let canRequestPermissionOnSettingList: Array<Permissions> = new Array();

      // 处理请求结果
      requestResult.authResults.forEach((authResult: number, index: number) => {
        if (index < permissionList.length) {
          let permission = permissionList[index];
          if (0 == authResult) {
            result.push(AtManagerHelper.createPermissionResult(permission, authResult)); // 用户已授权
          }
          else if (-1 == authResult) {
            // 用户未授权
            if (index < (requestResult.dialogShownResults?.length ?? 0)) {
              if (!(requestResult.dialogShownResults![index] ?? true)) {
                canRequestPermissionOnSettingList.push(permission); // 记录可以请求的权限
              }
              else {
                result.push(AtManagerHelper.createPermissionResult(permission, authResult, false));
              }
            }
            else {
              result.push(AtManagerHelper.createPermissionResult(permission, authResult, false));
            }
          }
          else if (2 == authResult) {
            result.push(AtManagerHelper.createPermissionResult(permission, authResult, true));
          }
          else {
            result.push(AtManagerHelper.createPermissionResult(permission, authResult, true));
          }
        }
        else {
        }
      });

      // 请求设置中的权限
      if (canRequestPermissionOnSettingList.length > 0) {
        let grantStatus: Array<abilityAccessCtrl.GrantStatus> =
          await atManager.requestPermissionOnSetting(context, permissionList);
        grantStatus.forEach((grantStatus: abilityAccessCtrl.GrantStatus, index: number) => {
          if (index < canRequestPermissionOnSettingList.length) {
            let permissionName = canRequestPermissionOnSettingList[index];
            if (abilityAccessCtrl.GrantStatus.PERMISSION_DENIED == grantStatus) {
              result.push(AtManagerHelper.createPermissionResult(permissionName, 0, true));
            }
            else if (abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED == grantStatus) {
              result.push(AtManagerHelper.createPermissionResult(permissionName, -1, true));
            }
          }
          else {
          }
        });
      }
    }
    catch (err) {
    }
    return result; // 返回权限结果数组
  }
}

/**
 * PermissionsName 命名空间包含所有权限名称的常量。
 */
export namespace PermissionsName {
  /**
   * 允许应用查看蓝牙的配置。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const USE_BLUETOOTH: string = 'ohos.permission.USE_BLUETOOTH';

  /**
   * 允许查询应用的基本信息。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const GET_BUNDLE_INFO: string = 'ohos.permission.GET_BUNDLE_INFO';

  /**
   * 允许应用关闭前执行自定义的预关闭动作。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 10
   */
  export const PREPARE_APP_TERMINATE: string = 'ohos.permission.PREPARE_APP_TERMINATE';

  /**
   * 允许应用获取打印框架的能力。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 10
   */
  export const PRINT: string = 'ohos.permission.PRINT';

  /**
   * 允许应用配置本地蓝牙，查找远端设备且与之配对连接。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const DISCOVER_BLUETOOTH: string = 'ohos.permission.DISCOVER_BLUETOOTH';

  /**
   * 允许应用读取加速度传感器的数据。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const ACCELEROMETER: string = 'ohos.permission.ACCELEROMETER';

  /**
   * 允许应用使用生物特征识别能力进行身份认证。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 6
   */
  export const ACCESS_BIOMETRIC: string = 'ohos.permission.ACCESS_BIOMETRIC';

  /**
   * 在本设备上允许应用访问通知策略。
   * 仅当控制铃声从静音到非静音时，需要申请该权限。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const ACCESS_NOTIFICATION_POLICY: string = 'ohos.permission.ACCESS_NOTIFICATION_POLICY';

  /**
   * 允许应用获取数据网络信息。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const GET_NETWORK_INFO: string = 'ohos.permission.GET_NETWORK_INFO';

  /**
   * 允许应用获取Wi-Fi信息。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const GET_WIFI_INFO: string = 'ohos.permission.GET_WIFI_INFO';

  /**
   * 允许应用读取陀螺仪传感器的数据。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const GYROSCOPE: string = 'ohos.permission.GYROSCOPE';

  /**
   * 允许使用Internet网络。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 9
   */
  export const INTERNET: string = 'ohos.permission.INTERNET';

  /**
   * 允许Service Ability在后台持续运行。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const KEEP_BACKGROUND_RUNNING: string = 'ohos.permission.KEEP_BACKGROUND_RUNNING';

  /**
   * 允许应用实现卡模拟功能。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const NFC_CARD_EMULATION: string = 'ohos.permission.NFC_CARD_EMULATION';

  /**
   * 允许应用读写Tag卡片。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const NFC_TAG: string = 'ohos.permission.NFC_TAG';

  /**
   * 允许应用将窗口设置为隐私窗口，禁止截屏录屏
   * 权限级别：API version 9-10为system_basic；从API version 11开始为normal。
   * 授权方式：system_grant
   * @since 9
   */
  export const PRIVACY_WINDOW: string = 'ohos.permission.PRIVACY_WINDOW';

  /**
   * 允许该应用使用后台代理提醒。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const PUBLISH_AGENT_REMINDER: string = 'ohos.permission.PUBLISH_AGENT_REMINDER';

  /**
   * 允许应用配置Wi-Fi设备。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const SET_WIFI_INFO: string = 'ohos.permission.SET_WIFI_INFO';

  /**
   * 允许应用控制马达振动。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const VIBRATE: string = 'ohos.permission.VIBRATE';

  /**
   * 允许应用根据包名清理相关后台进程。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const CLEAN_BACKGROUND_PROCESSES: string = 'ohos.permission.CLEAN_BACKGROUND_PROCESSES';

  /**
   * 允许应用发布粘性公共事件。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const COMMONEVENT_STICKY: string = 'ohos.permission.COMMONEVENT_STICKY';

  /**
   * 允许应用修改音频设置。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 8
   */
  export const MODIFY_AUDIO_SETTINGS: string = 'ohos.permission.MODIFY_AUDIO_SETTINGS';

  /**
   * 允许应用获取运行锁，保证应用在后台的持续运行。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const RUNNING_LOCK: string = 'ohos.permission.RUNNING_LOCK';

  /**
   * 允许应用设置壁纸。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 7
   */
  export const SET_WALLPAPER: string = 'ohos.permission.SET_WALLPAPER';

  /**
   * 允许应用进行查询证书及私有凭据等操作。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 9
   */
  export const ACCESS_CERT_MANAGER: string = 'ohos.permission.ACCESS_CERT_MANAGER';

  /**
   * 允许应用访问安全检测与响应框架。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 10
   */
  export const HSDR_ACCESS: string = 'ohos.permission.hsdr.HSDR_ACCESS';

  /**
   * 允许系统方舟运行时引擎在受限模式下执行动态下发的方舟字节码。
   * 该权限相关的API均为系统API，仅部分特定系统应用可申请该权限。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 11
   */
  export const RUN_DYN_CODE: string = 'ohos.permission.RUN_DYN_CODE';

  /**
   * 允许接入云空间的应用查询应用云同步相关配置信息。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 11
   */
  export const READ_CLOUD_SYNC_CONFIG: string = 'ohos.permission.READ_CLOUD_SYNC_CONFIG';

  /**
   * 允许应用存储持久化的数据，该数据直到设备恢复出厂设置或重装系统才会被清除。
   * 权限级别: normal
   * 授权方式：system_grant
   * @since 11
   */
  export const STORE_PERSISTENT_DATA: string = 'ohos.permission.STORE_PERSISTENT_DATA';

  /**
   * 允许应用使用外接设备增强功能。
   * 权限级别: normal
   * 授权方式：system_grant
   * @since 11
   */
  export const ACCESS_EXTENSIONAL_DEVICE_DRIVER: string = 'ohos.permission.ACCESS_EXTENSIONAL_DEVICE_DRIVER';

  /**
   * 允许应用读取用户账号的登录状态。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 12
   */
  export const READ_ACCOUNT_LOGIN_STATE: string = 'ohos.permission.READ_ACCOUNT_LOGIN_STATE';

  /**
   * 允许应用访问导航信息服务。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 12
   */
  export const ACCESS_SERVICE_NAVIGATION_INFO: string = 'ohos.permission.ACCESS_SERVICE_NAVIGATION_INFO';

  /**
   * 允许应用在锁屏后保护本应用敏感数据不被访问。
   * 应用获取此权限后，系统将给用户新建一个高安全级别el5的目录。应用可以在此目录下存放数据，这部分数据在锁屏后无法被访问。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 12
   */
  export const PROTECT_SCREEN_LOCK_DATA: string = 'ohos.permission.PROTECT_SCREEN_LOCK_DATA';

  /**
   * 允许应用支持持久化访问文件Uri。
   * 说明：该权限级别发生变更，为保证兼容性，在当前版本请继续采用受限权限申请方式申请使用该权限。
   * 权限级别：API version 11为system_basic; 从API version 12开始为normal。
   * 授权方式：system_grant
   * @since 11
   */
  export const FILE_ACCESS_PERSIST: string = 'ohos.permission.FILE_ACCESS_PERSIST';

  /**
   * 允许应用访问出行分布式业务引擎。
   * 权限级别：normal
   * 授权方式：system_grant
   * @since 12
   */
  export const ACCESS_CAR_DISTRIBUTED_ENGINE: string = 'ohos.permission.ACCESS_CAR_DISTRIBUTED_ENGINE';

  /**
   * 允许应用接入蓝牙并使用蓝牙能力，例如配对、连接外围设备等。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 10
   */
  export const ACCESS_BLUETOOTH: string = 'ohos.permission.ACCESS_BLUETOOTH';

  /**
   * 允许应用访问用户媒体文件中的地理位置信息。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   */
  export const MEDIA_LOCATION: string = 'ohos.permission.MEDIA_LOCATION';

  /**
   * 允许应用读取开放匿名设备标识符。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 9
   */
  export const APP_TRACKING_CONSENT: string = 'ohos.permission.APP_TRACKING_CONSENT';

  /**
   * 允许应用读取用户的运动状态。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   */
  export const ACTIVITY_MOTION: string = 'ohos.permission.ACTIVITY_MOTION';

  /**
   * 允许应用使用相机。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 9
   */
  export const CAMERA: string = 'ohos.permission.CAMERA';

  /**
   * 允许不同设备间的数据交换。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   */
  export const DISTRIBUTED_DATASYNC: string = 'ohos.permission.DISTRIBUTED_DATASYNC';

  /**
   * 允许应用在后台运行时获取设备位置信息。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   */
  export const LOCATION_IN_BACKGROUND: string = 'ohos.permission.LOCATION_IN_BACKGROUND';

  /**
   * 允许应用获取设备位置信息。
   * 申请条件：需要与模糊位置权限ohos.permission.APPROXIMATELY_LOCATION一起，才可申请此权限。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   */
  export const LOCATION: string = 'ohos.permission.LOCATION';

  /**
   * 允许应用获取设备模糊位置信息。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 9
   */
  export const APPROXIMATELY_LOCATION: string = 'ohos.permission.APPROXIMATELY_LOCATION';

  /**
   * 允许应用使用麦克风。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 8
   */
  export const MICROPHONE: string = 'ohos.permission.MICROPHONE';

  /**
   * 允许应用读取日历信息。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 8
   */
  export const READ_CALENDAR: string = 'ohos.permission.READ_CALENDAR';

  /**
   * 允许应用读取联系人数据。
   * 可申请此权限的特殊场景与功能：应用需要克隆、备份或同步联系人信息。
   * 其他场景下的使用方案： 使用“联系人Picker”访问联系人数据，使用方式请参考：选择联系人。
   * 授权方式： 用户授权（user_grant）
   * @since 8
   */
  export const READ_CONTACTS: string = 'ohos.permission.READ_CONTACTS';

  /**
   * 允许应用添加、移除或更改日历活动。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 8
   */
  export const WRITE_CALENDAR: string = 'ohos.permission.WRITE_CALENDAR';

  /**
   * 允许应用读取用户的健康数据。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   */
  export const READ_HEALTH_DATA: string = 'ohos.permission.READ_HEALTH_DATA';

  /**
   * 允许应用接入星闪并使用星闪能力，例如配对、连接外围设备等。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 12
   */
  export const ACCESS_NEARLINK: string = 'ohos.permission.ACCESS_NEARLINK';

  /**
   * 允许应用访问公共目录下Download目录及子目录。
   * 当前仅2in1设备应用可申请此权限。
   * 说明：该权限级别发生变更，为保证兼容性，在当前版本请继续采用受限权限申请方式申请使用该权限。
   * 权限级别：API version 11为system_basic; 从API version 12开始为normal。
   * 授权方式：user_grant
   * @since 11
   */
  export const READ_WRITE_DOWNLOAD_DIRECTORY: string = 'ohos.permission.READ_WRITE_DOWNLOAD_DIRECTORY';

  /**
   * 允许应用访问公共目录下的Documents目录及子目录。
   * 当前仅2in1设备应用可申请此权限。
   * 说明：该权限级别发生变更，为保证兼容性，在当前版本请继续采用受限权限申请方式申请使用该权限。
   * 权限级别：API version 11为system_basic; 从API version 12开始为normal。
   * 授权方式：user_grant
   * @since 11
   */
  export const READ_WRITE_DOCUMENTS_DIRECTORY: string = 'ohos.permission.READ_WRITE_DOCUMENTS_DIRECTORY';

  /**
   * 允许应用读取用户外部存储中的媒体文件信息。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   * @deprecated 12
   */
  export const READ_MEDIA: string = 'ohos.permission.READ_MEDIA';

  /**
   * 允许应用读写用户外部存储中的媒体文件信息。
   * 权限级别：normal
   * 授权方式：user_grant
   * @since 7
   * @deprecated 12
   */
  export const WRITE_MEDIA: string = 'ohos.permission.WRITE_MEDIA';
}