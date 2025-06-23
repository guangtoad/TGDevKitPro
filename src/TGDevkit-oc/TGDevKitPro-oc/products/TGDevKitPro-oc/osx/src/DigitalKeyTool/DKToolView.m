//
//  DKToolView.m
//  DKTool
//
//  Created by toad on 2021/08/16.
//

#import "DKToolView.h"

@implementation DKToolView
- (void) awakeFromNib{
    [super awakeFromNib];
}
#pragma mark-----将十六进制数据转换成NSData
- (NSData*)dataWithHexString:(NSString*)str{
    
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    range = NSMakeRange(0, 2);
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
    
}
- (NSString *) hexStringWithData:(NSData *)data{
    if (data) {
        return data.toHexString;
    }
    return @"";
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (IBAction) click_clear:(id)sender{
    
//    self.txt_inputData.string = @"";
    self.txt_sof.stringValue = @"";
    
    self.txt_Len.stringValue = @"";
    self.txt_LenNumber.stringValue = @"";
    
    self.txt_baoliu.stringValue = @"";
    self.txt_fangxinag.stringValue = @"";
    self.txt_jiami.stringValue = @"";
    self.txt_xiangying.stringValue = @"";
    self.txt_fenbao.stringValue = @"";
    
    self.txt_FSN.stringValue = @"";
    
    self.txt_MSG.stringValue = @"";
    
    self.txt_CMD.stringValue = @"";
    
    self.txt_T1.stringValue = @"";
    
    self.txt_L1.stringValue = @"";
    
    self.txt_Value.string = @"";
    
    self.txt_CRC.stringValue = @"";
    
}

- (void) getCarBleAuthon:(NSData *)carData{
    NSString *tlv = carData.toString;
    NSArray *array = [DigitalKeyTool authTLVPayloadTransfer:tlv];
    
    if (array.count > 0) {
        
        //车型信息
        NSString *readerType = @"";
        //车辆唯一标识
        NSString *readerId =  @"";
        //车端随机数
        self.readerRnd = @"";
        //用于认证的扩展字段 todo 32bytes
        //        NSString *readerAuthParameter = @"";
        
        for (BleProtocolFrameModel * model in array) {
            
            if ([model.type isEqualToString:@"9F35"]) {
                readerType = model.value;
            }else if ([model.type isEqualToString:@"9F1E"]){
                readerId = model.value;
            }else if ([model.type isEqualToString:@"9F37"]){
                self.txt_readerRnd.stringValue = model.value;
                self.readerRnd = model.value;
            }
            
        }
//        self.txt_cardRnd.stringValue
//        = [DigitalKeyTool randomString].lowercaseString;
//        XCarLog(@"readerRnd %@",self.readerRnd);

//        NSArray *fmdbArray = [[DigitalkeyFMDBManager sharedInstance] AllOwnerCarAuthorization];
//        if (fmdbArray.count == 0) {
//            //todo  kr ks没有下发
//            if (self.statusMessage) {
//                self.statusMessage(bleStatusMessage,FT_Business_Error,0xC3, @"本地没有钥匙", @"C3");
//            }
//            return;
//        }
//        NSString *kr;
//        for (DigitalkeyFMDBManagerModel *fmdbModel in fmdbArray) {
//
//            if ([fmdbModel.kr_vin isEqualToString:[DKGlobalSetting shareInstance].vinStr] && [fmdbModel.kr_status isEqualToString:@"1"]) {
//                self.carKS = fmdbModel.ks;
//                kr = fmdbModel.kr_krHex;
//                self.cardATC = fmdbModel.aux_cardAtc;//卡端计数器
//                self.apduKeyId = fmdbModel.kr_keyId;
//            }
//
//        }

        
//        if ([DigitalKeyTool isEmpty:self.carKS] || [DigitalKeyTool isEmpty:kr] || [DigitalKeyTool isEmpty:self.cardATC]) {
//            if (self.statusMessage) {
//                self.statusMessage(bleStatusMessage,FT_Business_Error,0xC3, @"本地没有钥匙", @"C3");
//            }
//            return;
//        }
    
        //卡端随机数 cardRnd 自己生成的随机数 8个字节16位
        self.cardRnd = [DigitalKeyTool randomString].lowercaseString;
        // 4bytes
        NSString *cardIV = @"00000000000000000000000000000000";//初始向量  默认全0
                                
        NSString *readerRnd_carRnd = [NSString stringWithFormat:@"%@%@",self.readerRnd,self.cardRnd];
        self.rcRnd = [DigitalKeyTool bodyAddFill80:readerRnd_carRnd];//[NSString stringWithFormat:@"%@80000000000000000000000000000000",readerRnd_carRnd];
        
//        XCoreLogDef(@"rcRnd = %@",self.rcRnd);
//        XCoreLogDef(@"carKS = %@",self.carKS);
//        XCoreLogDef(@"kr = %@",kr);
//        XCoreLogDef(@"cardATC = %@",self.cardATC);
        
        NSData *k2Data = [self.rcRnd.dataBytez AES128EncryptWithData:self.carKS.dataBytez iv:cardIV.dataBytez];
        
        //AES128_CBC 加密  K2=AES128_CBC(KS,CardIV,ReaderRnd|CardRnd);
        self.k2 = [k2Data.toString substringFromIndex:k2Data.toString.length - 32];
//        XCoreLogDef(@"k2 = %@",self.k2);
        
        NSString *cardATCTLV = [DigitalKeyTool tlvConstantsAdd:CarCardATC value:self.cardATC];
//        XCoreLogDef(@"cardATCTLV = %@",cardATCTLV);

        NSString *readerRndTLV = [DigitalKeyTool tlvConstantsAdd:CarVRnd value:self.readerRnd];
//        XCoreLogDef(@"readerRndTLV = %@",readerRndTLV);

        NSString *rcRndTLV = [NSString stringWithFormat:@"%@%@",cardATCTLV,readerRndTLV];
//        XCoreLogDef(@"rcRndTLV = %@",rcRndTLV);
        NSString *cartATC_readerRnd = [DigitalKeyTool bodyAddFill80:rcRndTLV];
//        XCoreLogDef(@"cartATC_readerRnd = %@",cartATC_readerRnd);
        NSData *s1Data = [cartATC_readerRnd.dataBytez AES128EncryptWithData:self.k2.dataBytez iv:readerRnd_carRnd.dataBytez];
        NSString *s1 = s1Data.toString;
//        XCoreLogDef(@"s1 = %@",s1);
        
        /**
         第三套tlv
         */
        NSString *a5 = [DigitalKeyTool tlvConstantsAdd:CarFiveA value:@"0000000000000000"];
//        NSString *b3 = [DigitalKeyTool tlvConstantsAdd:CarKeyId value:[kr substringFromIndex:kr.length-32]];
        NSString *e3 = [DigitalKeyTool tlvConstantsAdd:CarPRnd value:self.cardRnd];
        
        NSString *f05;
//        if (kr.length >= 128) {
//            NSString *typeStr = [DigitalKeyTool ToHexSrtingByFillZero:CarKR];
//            NSInteger length = kr.length/2;
//            NSString *lengthStr = [DigitalKeyTool ToHexSrtingByFillZero:length];
//            f05 = [NSString stringWithFormat:@"%@81%@%@",typeStr,lengthStr,kr];

//        }else{
//            f05 = [DigitalKeyTool tlvConstantsAdd:CarKR value:kr];
//        }
        
        NSString *s1tlv = [DigitalKeyTool tlvConstantsAdd:CarSevenThree value:s1];
//            [f05 stringByReplacingOccurrencesOfString:@"144A53313233343536B65045C19B47424D" withString:@"4A533132333435362F2971BA5C8E4DFF"];
//        NSString *value2 = [NSString stringWithFormat:@"%@%@%@%@%@",a5,b3,e3,f05,s1tlv];
//        XCoreLogDef(@"value2 = %@",value2);
        /**
         第二套tlv
         */
//        NSString *value1;
//        if (value2.length >= 128) {
//            NSString *typeStr = [DigitalKeyTool ToHexSrtingByFillZero:CarSeven];
//            NSInteger length = value2.length/2;
//            NSString *lengthStr = [DigitalKeyTool ToHexSrtingByFillZero:length];
//            value1 = [NSString stringWithFormat:@"%@81%@%@",typeStr,lengthStr,value2];
//
//        }else{
//            value1 = [DigitalKeyTool tlvConstantsAdd:CarSeven value:value2];
//        }
        
        /**
         第一套tlv  000100 stats 状态码  是成功还是失败  cardInfo超过128字节 length变为两个字节
         */
//        NSString *zoreOne = [DigitalKeyTool tlvConstantsAdd:CarZoreOne value:[NSString stringWithFormat:@"%@9000",value1]];
        
//        NSString *value0 = [NSString stringWithFormat:@"000100%@",zoreOne].lowercaseString;
//        XCoreLogDef(@"发送认证数据1 = %@",value0);
        
//        [[DigitalSendOutData sharedInstance] sendMultiPackageDataWithRequestOrResponse:ResponseValue Indicator:Synchronous CommandAndMessage:BLEAuth Encryption:NO payload:value0];
        
    }
    
}
- (IBAction) click_analysis:(id)sender{
    
    NSString *inputStr = self.txt_inputData.string;
    NSData *data = [self dataWithHexString:inputStr];
    NSInteger selectItem = [self.dataTypePopButton.menu indexOfItem:self.dataTypePopButton.selectedItem];
    NSData *body = NULL;
    NSInteger encryption = 0;
    NSInteger bodyLen = 0;
    
    NSUInteger loc = 0;
    NSUInteger len = 1;
    NSData *tmpData = NULL;
    
    if (1 == selectItem) {
        
        body = data;
    }
    else {
        
        tmpData = [data subDataWithLoc:data.length - 2 len:2];
        self.txt_CRC.stringValue = tmpData.toHexString;
        
        NSString *checkSum = tmpData.toString;
        NSString *checkValue = tmpData.toString;
        if (![checkValue.dataBytez.CRC16 isEqualToString:checkSum]) {
            
        }
        tmpData = [data subDataWithLoc:loc len:len];
        loc += len;
        self.txt_sof.stringValue = tmpData.toHexString;
        
        len = 2;
        tmpData = [data subDataWithLoc:loc len:len];
        loc += len;
        
        self.txt_Len.stringValue = tmpData.toHexString;
        bodyLen = tmpData.toString.toDecimal;
        self.txt_LenNumber.stringValue = [NSString stringWithFormat:@"%ld",bodyLen];
        len = 1;
        tmpData = [data subDataWithLoc:loc len:len];
        loc += len;
        {
            NSUInteger tLoc = 0;
            NSUInteger tLen = 3;
            NSString *controlString = [DigitalKeyTool getBinaryByhex:tmpData.toString];
            self.txt_baoliu.stringValue = [controlString substringWithLoc:tLoc len:tLen];
            tLoc += tLen;
            
            tLen = 1;
            self.txt_fangxinag.stringValue = [controlString substringWithLoc:tLoc len:tLen];
            tLoc += tLen;
            
            tLen = 1;
            NSString *encryptionStr = [controlString substringWithLoc:tLoc len:tLen];
            self.txt_jiami.stringValue = encryptionStr;
            encryption = [encryptionStr integerValue];
            tLoc += tLen;
            tLen = 1;
            self.txt_xiangying.stringValue = [controlString substringWithLoc:tLoc len:tLen];
            tLoc += tLen;
            
            tLen = 2;
            self.txt_fenbao.stringValue = [controlString substringWithLoc:tLoc len:tLen];
            tLoc += tLen;
            
        }
        
        tmpData = [data subDataWithLoc:loc len:len];
        loc += len;
        self.txt_FSN.stringValue = tmpData.toHexString;
        
        body = [data subDataWithLoc:5 len:bodyLen - 2];
        if (1 == encryption) {
            NSString *cardIV = @"00000000000000000000000000000000";//初始向量  默认全0
            NSData *k2Data = [self.txt_rcRnd.stringValue.dataBytez AES128DecryptWithData:self.txt_carKS.stringValue.dataBytez iv:cardIV.dataBytez];
            
    //        NSData *k2Data = [self.rcRnd.dataBytez AES128EncryptWithData:self.carKS.dataBytez iv:cardIV.dataBytez];
            [k2Data.toString substringFromIndex:k2Data.toString.length - 32];
    //        XCoreLogDef(@"k2 = %@",self.k2);
            
            NSString *ivString = [NSString stringWithFormat:@"%@%@",self.txt_readerRnd,self.txt_cardRnd];
             
            body = [[data subDataWithLoc:5 len:bodyLen - 2] AES128DecryptWithData:self.k2.dataBytez iv:ivString.dataBytez];
        }
        else {
            body = [data subDataWithLoc:5 len:bodyLen - 2];
        }
        
    }
        
    loc = 0;
    len = 1;
    tmpData = [body subDataWithLoc:loc len:len];
    loc += len;
    self.txt_MSG.stringValue = tmpData.toHexString;
    NSInteger MSG = tmpData.toString.toDecimal;
    
    tmpData = [body subDataWithLoc:loc len:len];
    loc += len;
    self.txt_CMD.stringValue = tmpData.toHexString;
    NSInteger CMD = tmpData.toString.toDecimal;
    
    NSData *payload = [body subDataWithLoc:loc len:body.length - loc];
    tmpData = [payload subDataWithLoc:2 len:2];
    
    switch (MSG) {
        case 0x01:
            switch (CMD) {
                case 0x01:
                    switch (tmpData.toString.toDecimal) {
                        case 0x80CA:{
                            [self getCarBleAuthon:[payload subDataWithLoc:7 len:payload.length - 7]];
                        }
                            break;
                            
                        default:
                            break;
                    }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    loc = 0;
    len = 1;
    tmpData = [payload subDataWithLoc:loc len:len];
    loc += len;
    self.txt_T1.stringValue = tmpData.toHexString;
    
    tmpData = [payload subDataWithLoc:loc len:len];
    loc += len;
    self.txt_L1.stringValue = tmpData.toHexString;
    
    tmpData = [payload subDataWithLoc:loc len:payload.length - loc];
    self.txt_Value.string = tmpData.toString;
    
}
@end
