//
//  ViewController.h
//  DKTool
//
//  Created by toad on 2021/08/13.
//

#import <Cocoa/Cocoa.h>

@interface DKToolViewController : NSViewController

@property (nonatomic,strong) IBOutlet NSTextField *txt_data;

#pragma mark - Header
@property (nonatomic,strong) IBOutlet NSTextField *txt_sof;

@property (nonatomic,strong) IBOutlet NSTextField *txt_Len;

@property (nonatomic,strong) IBOutlet NSTextField *txt_control;

@property (nonatomic,strong) IBOutlet NSTextField *txt_baoliu;
@property (nonatomic,strong) IBOutlet NSTextField *txt_baoliuhex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_fangxinag;
@property (nonatomic,strong) IBOutlet NSTextField *txt_fangxianghex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_jiami;
@property (nonatomic,strong) IBOutlet NSTextField *txt_jiamiHex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_xiangying;
@property (nonatomic,strong) IBOutlet NSTextField *txt_xiangyingHex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_fenbao;
@property (nonatomic,strong) IBOutlet NSTextField *txt_fenbaoHex;


@property (nonatomic,strong) IBOutlet NSTextField *txt_FSN;
@property (nonatomic,strong) IBOutlet NSTextField *txt_FSNHex;

#pragma mark - Body

@property (nonatomic,strong) IBOutlet NSTextField *txt_MSG;
@property (nonatomic,strong) IBOutlet NSTextField *txt_MSGHex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_CMD;
@property (nonatomic,strong) IBOutlet NSTextField *txt_CMDHex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_T1;
@property (nonatomic,strong) IBOutlet NSTextField *txt_T1Hex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_L1;
@property (nonatomic,strong) IBOutlet NSTextField *txt_L1Hex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_T2;
@property (nonatomic,strong) IBOutlet NSTextField *txt_T2Hex;

@property (nonatomic,strong) IBOutlet NSTextField *txt_L2;
@property (nonatomic,strong) IBOutlet NSTextField *txt_L2Hex;

@property (nonatomic,strong) IBOutlet NSTextView *txt_Value;

@property (nonatomic,strong) IBOutlet NSTextField *txt_CRC;
@property (nonatomic,strong) IBOutlet NSTextField *txt_CRCHex;

@end

