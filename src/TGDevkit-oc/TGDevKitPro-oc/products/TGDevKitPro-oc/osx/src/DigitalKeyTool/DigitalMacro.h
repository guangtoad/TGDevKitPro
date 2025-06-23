//
//  DigitalKeySdk.h
//  DigitalKeySdk
//
//  Created by greatrong on 2021/3/10.
//

#ifndef DigitalMacro_h
#define DigitalMacro_h

#define WeakSelf __weak typeof(self) weakSelf = self;


 
static NSString * const kUaesCentralManagerIdentifier  = @"kUaesCentralManagerIdentifier"; //Notify BNCM cycle send message to APP

//外设相关

// key 向光
static NSString * const kSTD_KEY_SERVICE_UUID  = @"FFE0"; //Write  APP send message to BLE
static NSString * const kSTD_KEY_CHARACTERISTIC_UUID  = @"FFE1"; //Notify BLE 配对

// 车辆相关
static NSString * const kSTD_VEHIClE_SERVICE_UUID  = @"FFF0"; //车辆服务 uuid
static NSString * const kSTD_VEHIClE_WRITE_CHARACTERISTIC_UUID  = @"FFFD"; // Write，Write Without Response
static NSString * const kSTD_VEHIClE_READ_NOTIFY_CHARACTERISTIC_UUID  = @"FFFE"; // Read, Notify


//开始扫描,连接, 认证,发送证书的情况下与设备的交互情
typedef enum {
    kcoreBlueStatusStartBle = 0,                //蓝牙准备中
    kcoreBlueStatusStartScan,                   //开始扫描  扫描中......
    kcoreBlueStatusConnecting,                  //连接中
    kcoreBlueStatusFailure,                     //失败
    kcoreBlueStatusConnected,                   //已连接
    kcoreBlueStatusNotifySuccess,               //订阅成功  身份认证
    kcoreBlueStatusConfirmSuccess,              //认证成功
    kcoreBlueStatusAuthenSuccess,               //鉴权成功  绑定
    kcoreBlueStatusReceiveCertificates,         //收到证书成功
    kcoreBlueStatusSendFactorV,                 //收到点数据到手机上 . 计算key.iv 可以发送同步数据  钥匙认证
    kcoreBlueStatusDigitalKey,                  //发送数字钥匙
    kcoreBlueStatusPositioning,                 //定位中

}  kcoreBlueStatus;

typedef NS_ENUM(NSInteger,DigitalCommandAndMessageValue){
    BLEAuth             = 0x0101,//蓝牙通讯认证 0x0101
    MobilePositioning   = 0x0201, //车控0x0201 蓝牙连接认证完成后通知手机开启测距定位 车-->手机
    AntiRelayJudgment   = 0x0202,//车控0x0202 指示手机启动防中继判断（本项目不使用）车-->手机
    RKEVehicleControl   = 0x0203, //0x0203 车端发送的车控指令  手机-->车
    RKENumberOfChallenges               = 0x0204,//0x0204  获取RKE挑战信息,以防止重放  手机-->车
    MobileAccessToVehicleInformation    = 0x0205,//0205  手机获取获取车辆信息  手机-->车
    VehicleControlObtainsMobilePhoneInformation = 0x0206,//0206  车控获取手机信息   车-->手机
    RTCClockCheck       = 0x0207,//RTC时钟校准 0x0207
    ICCEVersion         = 0x0208,//ICCE版本 0x0208
    PullAppActiveNotify = 0x0209, // 拉活APP通知0x0209
    OfflineTimes        = 0x020A,// 可使用离线次数查询0x020A
    APPStateNotify      = 0x0301,//移动终端主动向车辆通知移动终端的状态信息0x0301   手机-->车
    BLEAuthNotifify     = 0x0302,//蓝牙认证结果 0x0302,
//    CarStateNotify      = 0x0302,// 0x0302  车辆主动向移动终端通知车辆的状态信息，APDU执行结果在此消息中返回  车-->手机
    CarNotifyToApp      = 0x0303,//0x0303 车辆需要向APP通知的车辆信息  车-->手机
    DataRequestTransmittedFromVehicleEndToCloud = 0x0304,//0x0304车端请求透传到云端的数据请求 车-->手机
    TheMobilePhoneReturnsTheExecutionResultToTheCar = 0x0305, //0x0305车端请求透传到云端的数据请求后，异步处理完成后手机端将执行结果反馈给车端  手机-->车
    CarK1Active         = 0x8001,//钥匙激活 0x8001
    RTCCalibration      = 0x8002,//RTC手动校准
    SDKCarLogSearch     = 0x8003,//车端日志查询0x8003
    SDKBleStabilityTest = 0x8007,//蓝牙稳定性测试
    SDKCarStabilityTest = 0x8008,//车端稳定性测试

};

//requestOrResponse
typedef NS_ENUM(NSInteger,requestOrResponseValue){
    ResponseValue = 0,
    RequestValue = 1,
};

//响应指示位
typedef NS_ENUM(NSInteger,ResponseIndicatorBit){
    Synchronous = 0,  //同步
    Asynchronous = 1,  //异步
};



//RKE主动车控
typedef NS_ENUM(NSInteger,RequestRKEActiveCarControlValue){
    APPUnlock,//APP开锁
    APPLock,//APP闭锁
    APPOpenTheTrunk,//APP开启后备箱
    APPCloseTheTrunk,//APP关闭后备箱
    APPCarSearch,//APP寻车
};


//手机端返回的错误码如下response的含义
typedef NS_ENUM(NSInteger,ResponseStatueValue){
    APPSuccess,                                        //    0x00    成功
    ProcessingFailed,                               //    0x01    处理失败
    RequestForThisMessageIsNotSupported,            //    0x02    不支持该Message的请求
    RequestForThisCommandIsNotSupported,            //    0x03    不支持该Command的请求
    NoPermission,                                   //    0x04    无权限
    SystemBusy,                                     //    0x05    系统忙
    RequestFormatError,                             //    0x06    请求格式错误
    ParameterError,                                 //    0x07    参数错误
    AuthenticationFailure,                          //    0x08    设备认证失败/设备认证状态失效
    ResponseTimeout,                                //    0x09    响应超时
    InstructionReceived,                            //    0x0A    指令已收到，等待执行结果
    FrameSequenceError = 32,                             //    0x20    帧序列错误    连续帧序列号错误
    WrongSerialNumber,                              //    0x21    流水号错误
    PacketLengthNotLength,                          //    0x22    包长度与实际长度不符
    PacketLengthExceedMaximum,                      //    0x23    包长度超出最大接收缓存
    PacketCheckLengthError,                         //    0x24    组包校验长度错误
    MessageIDNotSupported,                          //    0x25    消息ID不支持    消息ID错误
    IDAndFirstReceived,                             //    0x26    多包时接收消息ID与首帧不一致
    TimeoutBetweenTwoPackets,                       //    0x27    两包数据传输之间超时 
};

//车端返回的错误码如下response的含义
typedef NS_ENUM(NSInteger,ResponseCarResultStatueValue){
    CarSuccess,                        //    0x00     成功
    CRCVerificationFailed,          //    0x01     CRC检验失败
    InputInvalidParameter,          //    0x02     输入无效参数
    SeReturnedError,                //    0x03     SE返回错误
    ApplicationSelectionFailed,     //    0x04     应用选择失败
    ApplicationSelectionReturnStatusIsIncorrect,//    0x05     应用选择返回状态不对
    SDKStatusError,                 //    0x06     SDK状态出错
    ErrorPackagingAPDUInstruction,  //    0x07     打包APDU指令出错
    SPINotIdle,                     //    0x08     SPI非空闲状态
    SeResetResponseFailed,          //    0x09     SE复位应答失败
    APDUInstructionTypeIsNotSupported,//    0x0A     不支持APDU指令类型
//    ValidityVerificationFailed,     //    0x0B     有效期校验失败
    FailedToGetTime,                //    0x0B     获取时间失败
    FailedToSetTime,                //    0x0C     设置时间失败
    ParameterEntryError,//    0x0D     参数项输入错误
    IllegalTimeFormat,//    0x0E     时间格式非法
    KeyExpired,//    0x0F     钥匙过期
    VehicleControlCommandCheckFailed,//    0x10     车控指令检查失败
    IncorrectRTCTimeFormat,//    0x11     RTC时间格式有误
    ActivationConditionJudgmentNotSatisfied,//    0x12     激活条件判断不满足
    OtaIsImplementedOnTheVehicleEndSecurityChip,//    0x13     车端安全芯片在执行OTA
    SequenceFrameError = 32,//    0x20     帧序列错误
    SerialNumberError,//    0x21     流水号错误
    PackageLengthDoesNotMatchActualLength,//    0x22     包长度与实际长度不符
    PacketLengthExceedsMaximumReceiveCache,//    0x23     包长度超出最大接收缓存
    WrongPackageCheckLength,//    0x24     组包校验长度错误
    MessageNotSupported,//    0x25     消息ID不支持
    messageIsInconsistentReceived,//    0x26     多包时接收消息ID与首帧不一致
    TimeoutBetweenTwoPacketsOfDataTransmission,//    0x27     两包数据传输之间超时
    KeyNotInEffect = 96,//    0x60     钥匙未生效
    ExpiredKey,//    0x61     钥匙已过期
};


//每次response返回的通用错误码将在Body-->Payload-->tlv数据type 标识
typedef NS_ENUM(NSInteger,CarResponsePayloadTLVType){
    CarZoreOne = 1,//01
    CarSeven = 119,//77
    CarSevenThree = 115,//73
    CarFiveA = 90,//5a
    CarKeyId = 40763, //9f3b
    CarPRnd = 40766,//9f3e
    CarKR = 40709,//9F05
    CarCardATC = 40758,//9f36
    CarVRnd = 40759,//9f37
    CarReaderID = 40734,//9f1e
    CarReaderType = 40757,//9F35
    CarReaderAuthDecryptTLV = 40714,//9F0A
    
};



#endif /* DigitalMacro_h */
