//
//  UserInfo.h
//  TGTestApp iOS
//
//  Created by toad on 2022/08/01.
//

#import <Foundation/Foundation.h>

/**
 用户身份

 - OrenterpriseTypeFirm: 企业
 - OrenterpriseTypePersonal: 个人
 */
typedef  NS_ENUM(NSInteger,OrenterpriseType){
    OrenterpriseTypeFirm = 0,// !>企业
    OrenterpriseTypePersonal = 1// !>个人
};
//用户身份 0.新用户;1.老用户;2.二手车;3.被授权;4.被移交;
/**
 用户身份

 - IdentitTypeNew: 新用户
 - IdentitTypeOld: 老用户
 - IdentitTypeErshou: 二手车
 - IdentitTypeBeishouquan: 被授权
 - IdentitTypeBeiyijiao: 被移交
 */
typedef NS_ENUM(NSInteger,UserIdentitType) {
    UserIdentitTypeNew = 0,
    UserIdentitTypeOld = 1,
    UserIdentitTypeErshou = 2,
    UserIdentitTypeBeishouquan = 3,
    UserIdentitTypeBeiyijiao = 4,
};
//*///----->//toad end
/**
 * @brief ユーザー情報管理クラス
 */
@interface UserInfo : NSObject {
 @private
    // StartEdit EDIT0001 [修正] 2011/11/19
    NSData *naviStatus_;
    NSData *naviPlan_;
    NSData *userId_;
    NSData *password_;
    NSData *telNo_;
    NSData *mailAddress_;
    NSData *agreementContent_;
    NSData *helpnetId_;
    NSData *helpnetStatus_;
    NSData *opsCenterTelNo_;
    NSData *opsNaviFlag_;
    NSData *gSecurityFlag_;
    NSData *espoUse_;
    NSData *memberStatus_; //20110128
    // EndEdit EDIT0001

#if 1    //    2014/03/06 T.Ichiba(ASK)
    NSData *keyM_;
    NSData *frameDivision_;
    NSData *frameNo_;
    NSData *vin_;
    NSData *carNameCode_;
    NSData *numberPlate_;
    NSData *planCode_;
    NSData *dpcCarTyp_;
    NSData *dcmSerial_;
#endif    //    2014/03/06 T.Ichiba(ASK)

    // StartEdit EDIT0001 [追加] 2011/11/19
    NSData *cardId_;            // カードID
    NSData *userType_;            // User Type  Add ver=1.90
    NSData *gbmlVersion_;        // 車載機バージョン
    NSData *startDate_;        // smartG-Link利用開始日
    NSData *cardKind_;        // カード種別
    NSData *lastNameKnj_;        // お客様名漢字1
    NSData *firstNameKnj_;    // お客様名漢字2
    NSData *lastNameKana_;    // お客様名カナ姓
    NSData *firstNameKana_;    // お客様名カナ名
    NSData *birthDay_;        // 生年月日
    NSData *postNo_;            // 郵便番号
    NSData *address_;            // 住所
    NSData *sexCls_;            // 性別区分
    NSData *sexName_;            // 性別名称
    NSData *celphonNo_;        // 携帯電話番号
    NSData *faxNo_;            // ファックス番号
    NSData *nickName_;        // 通称
    NSData *rtaCarNum_;        // 保有車両台数
    NSData *dateUpdDate_;        // データ更新日
    NSData *carName_;            // 車名
    NSData *regNo_;            // 登録No.
    NSData *salType_;            // 販売形式
    NSData *motExpDate_;        // 車検満了日
    // EndEdit EDIT0001
#if 1    //    2014/03/06 T.Ichiba(ASK)
    NSData *freePriodEndDate_;
    NSData *remoteUse_;
#endif    //    2014/03/06 T.Ichiba(ASK)
    NSData *gmemUse_;
// StartEdit EDIT0001 [追加] 2011/11/28
    NSData *glinkTelNo_;        // smartGLinkの利用登録、利用設定で使用する電話番号
    NSData *glinkMailAddress_;    // smartGLinkの利用登録、利用設定で使用するメールアドレス
// EndEdit EDIT0002
    
    // shiro add start
    NSData *naviCanUseFlg_;
    NSData *naviCanUseLimit_;
    // shiro add end

#if 1    //    2014/03/06 T.Ichiba(ASK)
    NSData *payMethod_;            // 支払い方法
    NSData *gbookStartDate_;    // G-BOOK利用開始日
    NSData *gbookExpDate_;        // G-BOOK契約満了日
#endif    //    2014/03/06 T.Ichiba(ASK)

#if 1    //    2014/10/23 T.Ichiba(ASK) G-カスタマイズ対応
    NSData *opsExpDate_;        // OPS有効期限
#endif    //    2014/10/23 T.Ichiba(ASK) G-カスタマイズ対応
    
    NSData *signed_status_;   //是否同意保密协议 0未同意 1同意
    // EDITYINSI001 Begin
    // Toad Edit[添加] 20190812 Begin---------->/*
    NSData *yinsi_signed_status_;   //是否同意保密协议 0未同意 1同意
    // Toad Edit End */
    // EDITYINSI001 End
    //
    // !!!:toad 添加:二期开发 身份验证----->    /*

    NSData *userguid_;// >!用户唯一标示
    NSData *useridentit_;// >!用户身份 0.新用户;1.老用户;2.二手车;3.被授权;4.被移交;int
    NSData *userorenterprise_;// >企业个人 0.法人;2.个人int
    NSData *activated_; //是否激活用户 1.已激活;2.未激活;

    /** 被授权用户：爱车信息 */
    NSData *car_location_;
    /** 被授权用户：爱车设置 */
    NSData *car_sertting_;
    /** 被授权用户：爱车位置 */
    NSData *car_information_;
    // EDIT314001 Begin
    // Toad Edit[改修] 20190916 Begin---------->/*
    /** 服务名称 */
    NSData *serviceName_;
    NSData *phoneNumber_;
    // Toad Edit End */
    // EDIT314001 End
    // EDITSNE001 Begin
    // Toad Edit[改修] 20191125 Begin---------->/*
    NSData *service_flg_;
    NSData *servicecenter_name_;
    NSData *services_name_;
    NSData *serviceaccount_name_;
    NSData *serviceuser_name_;
    NSData *gcollection_name_;
    // Toad Edit End */
    // EDITSNE001 End
    // Toad Edit End */
    // EDIT314001 End
    //*///----->//toad end
    
    // EDIT314001 Begin
    // nwb Edit[改修] 20200117 Begin---------->/*
    /** 颜色 */
    NSData *color_;
    NSData *modelSfx_;
    NSData *realName_;
    NSData *gender_;
    NSData *IdCardNo_;
    NSData *headImg_;
    NSData *dealerCode_;
    NSData *branchCode_;
    NSData *originalUser_;
    // Toad Edit End */
    // EDIT314001 End
    //*///----->//nwb end
    
    // EDIT21MM001 BEGIN
    // 21MM 800B新增节点  2021年03月05日 STA lxd
    NSData *dcmType_;
    NSData *dcmModelYear_;
    NSData *serviceNameDvs_;
    NSData *userName_;
    // 21MM 800B新增节点  2021年03月05日 END lxd
    // EDIT21MM001 END
    
    // EDITPARK001 BEGIN
    // 遥控泊车 SKB引导页逻辑变更对应  2021年12月02日 STA lxd
    NSData *activityA001_;
    // 遥控泊车 SKB引导页逻辑变更对应  2021年12月02日 END lxd
    // EDITPARK001 END
    
    // EDITAUTH001 BEGIN
    // 实名制认证对应 2022/05/23 START lxd
    NSData *realNameStatus_;
    // 实名制认证对应 2022/05/23 END lxd
    // EDITAUTH001 END

}
// StartEdit EDIT0001 [修正] 2011/11/19
// copyに修正
/**
 * @brief ナビステータス化
 */
@property(nonatomic, copy)NSString *naviStatus;

/**
 * @brief ナビプラン
 */
@property(nonatomic, copy)NSString *naviPlan;

/**
 * @brief ユーザーID
 */
@property(nonatomic, copy)NSString *userId;

/**
 * @brief パスワード
 */
@property(nonatomic, copy)NSString *password;

/**
 * @brief 電話番号
 */
@property(nonatomic, copy)NSString *telNo;

/**
 * @brief メールアドレス
 */
@property(nonatomic, copy)NSString *mailAddress;

/**
 * @brief 利用規約
 */
@property(nonatomic, copy)NSString *agreementContent;

/**
 * @brief ヘルプネット利用ID
 */
@property(nonatomic, copy)NSString *helpnetId;

/**
 * @brief ヘルプネット登録ステータス
 */
@property(nonatomic, copy)NSString *helpnetStatus;

/**
 * @brief オペレーターサービス（SP）用の電話番号
 */
@property(nonatomic, copy)NSString *opsCenterTelNo;

/**
 * @brief G-BOOK車載ナビOPS可否
 */
@property(nonatomic, copy)NSString *opsNaviFlag;

/**
 * @brief G-Security対応可否
 */
@property(nonatomic, copy)NSString *gSecurityFlag;

/**
 * @brief ESPO利用可否
 */
@property(nonatomic, copy)NSString *espoUse;

/**
 * @brief 会員の登録状態
 * @warning getterは常にkMemberFormal、setterはnop
 */
@property(nonatomic, copy)NSString *memberStatus; //20110128

/**
 * @brief YES:オペレーターメールを受信する
 */
@property(nonatomic, readonly)BOOL useOps;

/**
 * @brief YES:TS3会員
 */
@property(nonatomic, readonly)BOOL isTS3Member; //20110530

// EndEdit EDIT0001

#if 1    //    2014/03/06 T.Ichiba(ASK)
@property(nonatomic, copy) NSString *keyM;
@property(nonatomic, copy) NSString *frameDivision;
@property(nonatomic, copy) NSString *frameNo;
@property(nonatomic, copy) NSString *vin;
@property(nonatomic, copy) NSString *carNameCode;
@property(nonatomic, copy) NSString *numberPlate;
@property(nonatomic, copy) NSString *planCode;
@property(nonatomic, copy) NSString *dpcCarTyp;
@property(nonatomic, copy) NSString *dcmSerial;
#endif    //    2014/03/06 T.Ichiba(ASK)

// StartEdit EDIT0001 [追加] 2011/11/19
/**
 * @brief カードID
 */
@property(nonatomic, copy) NSString *cardId;

/**
 * @brief 車載機バージョン
 */
@property(nonatomic, copy) NSString *gbmlVersion;

/**
 * @brief smartG-Link利用開始日
 */
@property(nonatomic, copy) NSString *startDate;

/**
 * @brief カード種別
 */
@property(nonatomic, copy) NSString *cardKind;

/**
 * @brief お客様名漢字1
 */
@property(nonatomic, copy) NSString *lastNameKnj;

/**
 * @brief お客様名漢字2
 */
@property(nonatomic, copy) NSString *firstNameKnj;

/**
 * @brief お客様名カナ姓
 */
@property(nonatomic, copy) NSString *lastNameKana;

/**
 * @brief お客様名カナ名
 */
@property(nonatomic, copy) NSString *firstNameKana;

/**
 * @brief 生年月日
 */
@property(nonatomic, copy) NSString *birthDay;
/**
 * @brief 郵便番号
 */
@property(nonatomic, copy) NSString *postNo;
/**
 * @brief 住所
 */
@property(nonatomic, copy) NSString *address;
/**
 * @brief 性別区分
 */
@property(nonatomic, copy) NSString *sexCls;
/**
 * @brief 性別名称
 */
@property(nonatomic, copy) NSString *sexName;
/**
 * @brief 携帯電話番号
 */
@property(nonatomic, copy) NSString *celphonNo;
/**
 * @brief ファックス番号
 */
@property(nonatomic, copy) NSString *faxNo;
/**
 * @brief 通称
 */
@property(nonatomic, copy) NSString *nickName;
/**
 * @brief 保有車両台数
 */
@property(nonatomic, copy) NSString *rtaCarNum;
/**
 * @brief データ更新日
 */
@property(nonatomic, copy) NSString *dateUpdDate;
/**
 * @brief 車名
 */
@property(nonatomic, copy) NSString *carName;
/**
 * @brief 登録No.
 */
@property(nonatomic, copy) NSString *regNo;
/**
 * @brief 販売形式
 */
@property(nonatomic, copy) NSString *salType;
/**
 * @brief 車検満了日化
 */
@property(nonatomic, copy) NSString *motExpDate;
@property(nonatomic, copy) NSString *freePriodEndDate;
@property(nonatomic, copy) NSString *remoteUse;
@property(nonatomic, copy) NSString *gmemUse;
/**
 * @brief OPS有効期限
 */
@property(nonatomic, copy) NSString *opsExpDate;
/**
 * @brief YES:オーナーカード会員 NO:サービスカード会員
 */
@property(nonatomic, readonly) BOOL isOwners;
/**
 * @brief YES:G-Linkナビ契約あり
 */
@property(nonatomic, readonly) BOOL hasGLinkContract;
/**
 * @brief YES:ESPO対応ユーザ
 */
@property(nonatomic, readonly) BOOL isEspoUser;

//20130729 kawai G-LINK Lite対応
/**
 * @brief YES:Lite会員 NO:非Lite会員
 */
@property(nonatomic, readonly) BOOL isLiteUser;
//20130729 end

// StartEdit EDIT0002 [追加] 2011/11/28
/**
 * @brief smartGLinkの利用登録、利用設定で使用する電話番号化
 */
@property(nonatomic, copy) NSString *glinkTelNo;

/**
 * @brief smartGLinkの利用登録、利用設定で使用するメールアドレス化
 */
@property(nonatomic, copy) NSString *glinkMailAddress;
// EndEdit EDIT0002

// 201303号口開発 by H.K begin
///@brief 地図バージョン
@property(nonatomic, retain)NSString *nvlMapVer;
///@brief 地図ＵＲＬ
@property(nonatomic, retain)NSString *nvlMapUrl;
///@brief 地図更新可否フラグ
@property(nonatomic, retain)NSString *nvlMapUpdFlg;

///@brief 会員種別
@property(nonatomic, retain)NSString *userType;

// 201303号口開発 by H.K end

// 20130422 K.S お知らせ対応 begin
///@brief 押し出し情報
@property(nonatomic, retain)NSArray *pushOutArray;
///@brief おしらせ情報
@property(nonatomic, retain)NSArray *announceArray;
///@brief 有効期限情報
@property(nonatomic, retain)NSArray *limitArray;
// 20130422 K.S お知らせ対応 end

// shiro add start
@property(nonatomic, retain)NSString *naviCanUseFlg;
@property(nonatomic, retain)NSString *naviCanUseLimit;
// shiro add end


/**
 * @brief 支払い方法
 */
@property(nonatomic, copy) NSString *payMethod;

/**
 * @brief G-BOOK利用開始日
 */
@property(nonatomic, copy) NSString *gbookStartDate;

/**
 * @brief G-BOOK契約満了日
 */
@property(nonatomic, copy) NSString *gbookExpDate;

/**
 * @brief 是否同意保密协议 1同意 0未同意
 */
@property(nonatomic, copy) NSString *signed_status;
// EDITYINSI001 Begin
// Toad Edit[新增] 20190812 Begin---------->/*

/**
 * @brief 是否同意隐私协议 1同意 0未同意
 */
@property(nonatomic, copy) NSString *yinsi_signed_status;
// Toad Edit End */
// EDITYINSI001 End
@property (nonatomic,strong) NSString *phoneNumber;

/** 用户唯一标示 @code
 USER_GUID
 @endcode*/
@property (nonatomic,copy) NSString *userguid;
/** 用户身份 0.新用户;1.老用户;2.二手车;3.被授权;4.被移交; 5.无车用户;*/
@property (nonatomic,readonly) NSInteger useridentit;
/** 企业个人 0.法人;1.个人 */
@property (nonatomic,readonly) NSInteger userorenterprise;
/** 激活状态 1.一激活;0.未激活 */
@property (nonatomic,readonly) NSInteger activated;
/** 被授权用户：爱车信息 */
@property (nonatomic,readonly) NSInteger car_information;
/** 被授权用户：爱车设置 */
@property (nonatomic,readonly) NSInteger car_sertting;
/** 被授权用户：爱车位置 */
@property (nonatomic,readonly) NSInteger car_location;
/** 服务名称 */
@property (nonatomic,strong) NSString *serviceName;

/// 服务标记
@property (nonatomic,assign) NSInteger service_flg;
/// XX服务
@property (nonatomic,strong) NSString *services_name;
/// XX支持中心
@property (nonatomic,strong) NSString *servicecenter_name;
/// xx账户
@property (nonatomic,strong) NSString *serviceaccount_name;
/// XX用户
@property (nonatomic,strong) NSString *serviceuser_name;
/// xx收藏
@property (nonatomic,strong) NSString *gcollection_name;

// !!!:lxd 添加:21mm相关  800新增节点----->    /*
// EDIT21MM001 BEGIN
// 21MM 800B新增节点  2021年03月05日 STA lxd
@property (nonatomic, strong) NSString * dcmType;
@property (nonatomic, strong) NSString * dcmModelYear;
/// 服务名标记
@property (nonatomic, assign) NSInteger serviceNameDvs;
/// 800B用户判断
@property (nonatomic, assign) BOOL is800BUser;
@property (nonatomic, strong) NSString * userName;
// 21MM 800B新增节点  2021年03月05日 END lxd
// EDIT21MM001 END

// EDITPARK001 BEGIN
// 遥控泊车 SKB引导页逻辑变更对应  2021年12月02日 STA lxd
/// SKB引导活动开启状态：1-开启  0-未开启
@property (nonatomic, strong) NSString * activityA001;
// 遥控泊车 SKB引导页逻辑变更对应  2021年12月02日 END lxd
// EDITPARK001 END

// EDITAUTH001 BEGIN
// 实名制认证对应 2022/05/23 START lxd
/// 实名认证状态
@property (nonatomic, strong) NSString *realNameStatus;
// 实名制认证对应 2022/05/23 END lxd
// EDITAUTH001 END

@property(nonatomic, copy) NSString *color;
@property(nonatomic, copy) NSString *modelSfx;
@property (nonatomic,copy) NSString *realName;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *IdCardNo;
@property (nonatomic,copy) NSString *headImg;
@property (nonatomic,copy) NSString *dealerCode;
@property (nonatomic,copy) NSString *branchCode;
@property (nonatomic,copy) NSString *originalUser;
// EndEdit nwb
@property (nonatomic)BOOL useridentitChanged;
@end

// 20130327 K.S 認証対応 begin
@interface PushOutInfo : NSObject {
    NSString*pushOutTelNo;
    NSString*internalDevice;
}
///@brief Myルート登録件数
@property(nonatomic, retain)NSString *pushOutTelNo;
///@brief SEQ番号
@property(nonatomic, retain)NSString *internalDevice;
@end

@interface AnnounceInfo : NSObject {
    NSString*Data;
    NSString*title;
    NSString*msg;
}
///@brief 日付
@property(nonatomic, retain)NSString *date;
///@brief タイトル
@property(nonatomic, retain)NSString *title;
///@brief メッセージ
@property(nonatomic, retain)NSString *msg;
@end
