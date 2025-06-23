//
//  Vehicle.h
//  TGTestApp iOS
//
//  Created by toad on 2022/08/01.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Vehicle : NSObject

@property (nonatomic,assign) NSString *FRAME_DIVISION;
@property (nonatomic,assign) NSString *FRAME_NO;
/// 车辆VIN
@property (nonatomic,assign) NSString *VIN;
/// 车型标示
@property (nonatomic,assign) NSString *CAR_NAME_CODE;
/// 车型
@property (nonatomic,assign) NSString *CAR_NAME;
@property (nonatomic,assign) NSString *NUMBER_PLATE;
/// 车牌号
@property (nonatomic,assign) NSString *PLAN_CODE;
@property (nonatomic,assign) NSString *GBML_VERSION;
@property (nonatomic,assign) NSString *DPCCARTYP;
@property (nonatomic,assign) NSString *DCMSERIAL;
@property (nonatomic,assign) NSString *CARD_KIND;
@property (nonatomic,assign) NSString *GBOOKID;
@property (nonatomic,assign) NSString *NAVI_PLAN;
@property (nonatomic,assign) NSString *OPS_USE;
@property (nonatomic,assign) NSString *IDENT_ID;
@property (nonatomic,assign) NSString *USER_INTERNAL_ID;
@property (nonatomic,assign) NSString *USER_IDENTITY;
@property (nonatomic,assign) NSString *USERORENTERPRISE;
@property (nonatomic,assign) NSString *RULES;
@property (nonatomic,assign) NSString *CARTYPE;
/// 服务名称
@property (nonatomic,assign) NSString *SERVICE_NAME;
/// 服务表示
@property (nonatomic,assign) NSString *SERVICE_FLG;
/// 服务中心名称
@property (nonatomic,assign) NSString *SERVICECENTER_NAME;
/// 服务名称
@property (nonatomic,assign) NSString *SERVICES_NAME;
/// 服务客服名称
@property (nonatomic,assign) NSString *SERVICEACCOUNT_NAME;
/// 服务人员名称
@property (nonatomic,assign) NSString *SERVICEUSER_NAME;
@property (nonatomic,assign) NSString *GCOLLECTION_NAME;
@property (nonatomic,assign) NSString *SERVICE_NAME_DVS;
@property (nonatomic,assign) NSString *IS_REISSUEOWNERSID;
@property (nonatomic,assign) NSString *REISSUE_DATE ;
/// 是否时电动车
@property (nonatomic,assign) NSString *ISEVCAR;
/// 车辆DM类型
@property (nonatomic,assign) NSString *DCMTYPE;
@property (nonatomic,assign) NSString *DCMMODELYEAR;
@property (nonatomic,assign) NSString *CARD_ID;
@property (nonatomic,assign) NSString *USER_ID;
/// 购车名称1
@property (nonatomic,assign) NSString *NAME_KNJ_1;
/// 购车名称2
@property (nonatomic,assign) NSString *NAME_KNJ_2;
@property (nonatomic,assign) NSString *BRT_DAY;
@property (nonatomic,assign) NSString *POST_NO;
@property (nonatomic,assign) NSString *ADR_1;
@property (nonatomic,assign) NSString *TEL_NO;
@property (nonatomic,assign) NSString *TEL_NO2 ;
@property (nonatomic,assign) NSString *TEL_NO3 ;
@property (nonatomic,assign) NSString *SEX_CLS ;
@property (nonatomic,assign) NSString *SEX_NAME;
@property (nonatomic,assign) NSString *NICKNAME;
@property (nonatomic,assign) NSString *DATA_UPD_DATE;
@property (nonatomic,assign) NSString *GLINK_CONTRACT;
@property (nonatomic,assign) NSString *PAY_METHOD ;
@property (nonatomic,assign) NSString *START_DATE;
@property (nonatomic,assign) NSString *EXP_DATE;
@property (nonatomic,assign) NSString *NAVI_STATUS;
@property (nonatomic,assign) NSString *ESPO_USE;
@property (nonatomic,assign) NSString *REMOTE_USE;
@property (nonatomic,assign) NSString *REG_NO;
@property (nonatomic,assign) NSString *FREE_PERIOD_END_DATE;
@property (nonatomic,assign) NSString *SIGNED_STATUS;
@property (nonatomic,assign) NSString *PRIVACY_SIGNED_STATUS;
@end

NS_ASSUME_NONNULL_END
