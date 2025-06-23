//
//  DKToolView.h
//  DKTool
//
//  Created by toad on 2021/08/16.
//

#import <Cocoa/Cocoa.h>

#import "NSData+TG.h"

#import "NSData+UAESUntil.h"
#import "NSString+UAESUntil.h"
#import "DigitalKeyTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKToolView : NSView

/**
 *卡端计数器
 */
@property (nonatomic,copy)NSString *cardATC;
/**
 设置KS
 */
@property (nonatomic,copy)NSString *carKS;
/**
 
 */
@property (nonatomic,copy)NSString *k2;
/**
 
 */
@property (nonatomic,copy)NSString *rcRnd;
/**
 车侧随机数
 */
@property (nonatomic,copy)NSString *readerRnd;

/**
 卡端随机数
 */
@property (nonatomic,copy)NSString *cardRnd;

@property (nonatomic,strong) IBOutlet NSTextField *txt_rcRnd;
@property (nonatomic,strong) IBOutlet NSTextField *txt_carKS;
@property (nonatomic,strong) IBOutlet NSTextField *txt_kr;
@property (nonatomic,strong) IBOutlet NSTextField *txt_cardATC;
@property (nonatomic,strong) IBOutlet NSTextField *txt_readerRnd;
@property (nonatomic,strong) IBOutlet NSTextField *txt_cardRnd;
@property (nonatomic,strong) IBOutlet NSTextView *txt_inputData;

@property (nonatomic,strong) IBOutlet NSPopUpButton *dataTypePopButton;


#pragma mark - Header
@property (nonatomic,strong) IBOutlet NSTextField *txt_sof;

@property (nonatomic,strong) IBOutlet NSTextField *txt_Len;
@property (nonatomic,strong) IBOutlet NSTextField *txt_LenNumber;

@property (nonatomic,strong) IBOutlet NSTextField *txt_control;
@property (nonatomic,strong) IBOutlet NSTextField *txt_baoliu;

@property (nonatomic,strong) IBOutlet NSTextField *txt_fangxinag;

@property (nonatomic,strong) IBOutlet NSTextField *txt_jiami;

@property (nonatomic,strong) IBOutlet NSTextField *txt_xiangying;

@property (nonatomic,strong) IBOutlet NSTextField *txt_fenbao;

@property (nonatomic,strong) IBOutlet NSTextField *txt_FSN;

#pragma mark - Body

@property (nonatomic,strong) IBOutlet NSTextField *txt_MSG;

@property (nonatomic,strong) IBOutlet NSTextField *txt_CMD;

@property (nonatomic,strong) IBOutlet NSTextField *txt_T1;

@property (nonatomic,strong) IBOutlet NSTextField *txt_L1;

@property (nonatomic,strong) IBOutlet NSTextView *txt_Value;

@property (nonatomic,strong) IBOutlet NSTextField *txt_CRC;

@end

NS_ASSUME_NONNULL_END
