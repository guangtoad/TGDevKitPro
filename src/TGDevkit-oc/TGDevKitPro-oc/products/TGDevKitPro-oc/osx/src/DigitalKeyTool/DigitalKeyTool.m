//
//  DigitalKeyTool.m
//  DigitalWhiteBox
//
//  Created by greatrong on 2021/3/10.
//

#import "DigitalKeyTool.h"
//#import "DigitalXLog.h"
#import "BleProtocolFrameModel.h"
//#import "DigitalSendOutData.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import "NSString+UAESUntil.h"
#import "NSData+UAESUntil.h"
//#import "UUIDManager.h"
#include <sys/types.h>
#include <sys/sysctl.h>


//@implementation UIDevice (ModelVersion)
//
//- (NSString*)modelVersion
//{
//    size_t size;
//
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char* machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString* platform = [NSString stringWithUTF8String:machine];
//    free(machine);
//
//    return platform;
//}
//
//@end


@implementation DigitalKeyTool

static DigitalKeyTool* requestData = nil;
+ (DigitalKeyTool*)sharedInstance{
    // lazy instantiation
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestData = [[DigitalKeyTool alloc] init];
    });
    return requestData;
}

#pragma mark - 转化字符串
+ (NSString *)isBlankString:(id)string{
    
    if (string == nil) {
        return @"";
    }
    
    if (string == NULL) {
        return @"";
    }
    
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([string isKindOfClass:[NSDecimalNumber class]] || [string isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",string];
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return @"";
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return @"";
    }
    
    return string;
    
}

+ (BOOL)isEmpty:(NSString *)string{
    if ([[DigitalKeyTool isBlankString:string] isEqual:@""]) {
        return YES;
    }
    return NO;
}

//MARK: 转json
+ (NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    
    if (!jsonData) {
//        XAPILogInf(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}


//Ascii转十六进制
//MARK: Ascii转十六进制
+ (NSString *)hexStringFromString:(NSString *)string{
    
    if (!string || [string length] == 0) {
        return @"";
    }
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
    
}

/**
 *将data转换为不带<>的字符串
 * @param data 二进制数
 */
+ (NSString *)convertToNSStringWithNSData:(NSData *)data
{
    NSMutableString *strTemp = [NSMutableString stringWithCapacity:[data length]*2];
    const unsigned char *szBuffer = [data bytes];
    for (NSInteger i=0; i < [data length]; ++i) {
        [strTemp appendFormat:@"%02lx",(unsigned long)szBuffer[i]];
    }
    return strTemp;
}

// 十六进制转二进制
+(NSString *)getBinaryByhex:(NSString *)hex
{
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binary = @"";
    for (int i=0; i<[hex length]; i++) {
        
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}

/**
 二进制转换成十六进制
 
 @param binary 二进制数
 @return 十六进制数
 */
//MARK: 二进制转换成十六进制
+ (NSString *)getHexByBinary:(NSString *)binary {
    
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i=0; i<binary.length; i+=4) {
        
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}

/**
 *十六进制转Ascii
 *十六进制传十进制
 */
//MARK: 十六进制转Ascii
+(NSString*)getASCIIString:(NSString*)strHex
{
    NSString * strAscii = [NSString stringWithFormat:@"%lu",strtoul([strHex UTF8String],0,16)];
    //    NSString *revStr = [DigitalKeyTool reversalString:strAscii];
    
    return strAscii;
}

/**
 字符串倒叙
 */
+(NSString *)reversalString:(NSString *)originString{
    NSString *resultStr = @"";
    for (NSInteger i = originString.length -1; i >= 0; i--) {
        NSString *indexStr = [originString substringWithRange:NSMakeRange(i, 1)];
        resultStr = [resultStr stringByAppendingString:indexStr];
    }
    return resultStr;
}

/***
    十六进制 字符串 倒序
 */
//MARK: 十六进制 字符串 倒序
+(NSString *)reverseHexString:(NSString *)hexString{
    NSMutableData* data  = [DigitalKeyTool convertHexStrToData:hexString];
    NSInteger len = [data length];
    
    NSMutableString *strTemp = [NSMutableString stringWithCapacity:[data length]*2];
    const unsigned char *szBuffer = [data bytes];
    
    for (NSInteger i=0; i < [data length]; ++i) {
        [strTemp appendFormat:@"%02lx",(unsigned long)szBuffer[len-i-1]];
    }
    
    NSString* upperStr = [strTemp uppercaseString];
    return upperStr;
}


/**
 蓝牙配对码
 @parm vinCodel  名字
 @parm num 随机数
 */
// MARK: 蓝牙配对码
+(NSString *)getBlePeiCode:(NSString *)vinCodel withCode:(NSString *)num{
    // XCoreLogDef(@"getBlePeiCode:%@ withCode:%@",vinCodel, num);

    // 项目简称+VIN
    //name获取vin码
    NSString *vins = [vinCodel substringFromIndex:vinCodel.length-12];
    // XCoreLogDef(@"vin码 %@",vins);
    //vin倒叙
    NSString *revStr = [DigitalKeyTool reversalString:vins];
    //vin转16进制
    NSString *vinHexString = [DigitalKeyTool hexStringFromString:revStr];
    //第一次哈希
    NSString *sha1 = vinHexString.dataBytez.sha2_256.toString.lowercaseString;
    // XCoreLogDef(@"vinSha256_round1 %@",sha1);
    
    //第二次哈希
    NSString *sha = sha1.dataBytez.sha2_256.toString.lowercaseString;
    // XCoreLogDef(@"vinSha256_round2 %@",sha);
    
    //获取vin 两次SHA256 取低位4字节
    NSString *dfStr = [sha substringToIndex:8];
    // XCoreLogDef(@"vinSha256_round2低位4字节 %@",dfStr);
    
    //vin转二进制
    NSString *aaa = [DigitalKeyTool getBinaryByhex:dfStr];
    
    //随机数低位获取
    NSString *bbb = [DigitalKeyTool getBinaryByhex:num];
    // XCoreLogDef(@"随机数 %@",bbb);
    
    //异或运算
    NSString *dds = [self pinxCreator:aaa withPinv:bbb];
    NSString *xorStr = [DigitalKeyTool getHexByBinary:dds];
    // XCoreLogDef(@"异或运算 %@",xorStr);

    //取高位的3字节
    NSString *lowStr = [xorStr substringFromIndex:xorStr.length - 6];
    //lowStr  转10进制
    NSString *tenStr = [NSString stringWithFormat:@"%lu",strtoul([lowStr UTF8String],0,16)];
    
    NSString *peiCode = @"";
    int code = tenStr.intValue % 1000000;
    // XCoreLogDef(@"异或结果求余数 %d",code);
    
    if (code >= 100000) {
        peiCode = [NSString stringWithFormat:@"%d",code];
    }else{
        peiCode = [NSString stringWithFormat:@"%d",code+100000];
    }
    return  peiCode;
    
}

/**
 两个数的异或运算
 */
//MARK: 两个数的异或运算
+(NSString *)pinxCreator:(NSString *)pan withPinv:(NSString *)pinv{
    
    const char *panchar = [pan UTF8String];
    const char *pinvchar = [pinv UTF8String];
    
    NSString *temp = @"";
    
    for (int i = 0; i < pan.length; i++)
    {
        if (panchar[i] == pinvchar[i]) {
            temp = [NSString stringWithFormat:@"%@%@",temp,@"0"];
        }else{
            temp = [NSString stringWithFormat:@"%@%@",temp,@"1"];
        }
    }
    return temp;
    
}

// MARK:将十进制转化为十六进制
+(NSString *)ToHex:(int)tmpid{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

+(NSString *)ToHexSrtingByFillZero:(NSInteger)number{
    NSString *hexStr = [NSString stringWithFormat:@"%lx",(long)number];
    if (hexStr.length%2 != 0) {
        hexStr = [@"0" stringByAppendingString:hexStr];
    }
    return hexStr;
}


// MARK: 普通字符串转换为十六进
+ (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];
        
        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }
        
        hexStr = [hexStr stringByAppendingString:newHexStr];
        
    }
    return hexStr;
}

/**
 *payload处理
 */
+(NSString *)getPayloadFromCarHex:(NSString *)payload{
    
    BleProtocolFrameModel *model = [[BleProtocolFrameModel alloc] init];
    //todo
    model.body.payload = [payload substringWithRange:NSMakeRange(18,payload.length - 18)];
    
    
    return @"";
}

//再补充个stringToByte的方法： 十六进制转二进制
//MARK: 十六进制转二进制
+ (NSMutableData*)convertHexStrToData:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else if(hex_char1 >= 'a' && hex_char1 <='f')
            int_ch1 = (hex_char1-87)*16; //// A 的Ascll - 97
        
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        
        else if(hex_char2 >= 'a' && hex_char2 <='f' ) {
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        }
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}


+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    // 转为大写 ，系统内为小写
    NSString* stringUp = [string uppercaseString];
    return stringUp;
}

/**
 对payload处理
 */
//MARK: 蓝牙数据payload处理
+(NSMutableArray *)TLVPayloadTransfer:(NSString *)payloadHex{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    int index = 0;
    int totalIndex = 0;
        
    @try{
    //1:抛出异常的代码
    //2:代码
        do {
            
            BleProtocolFrameModel * model = [[BleProtocolFrameModel alloc] init];
            
            model.type = [payloadHex substringWithRange:NSMakeRange(index,2)];
            model.length = [payloadHex substringWithRange:NSMakeRange(2+index,2)];
            
            NSString *tenStr = [NSString stringWithFormat:@"%lu",strtoul([model.length UTF8String],0,16)];
            
            index = tenStr.intValue*2;
            
            model.value = [payloadHex substringWithRange:NSMakeRange(4+totalIndex,index)];
            
            index = index + 4;
            totalIndex = totalIndex + index;
            
            [arr addObject:model];
            
        } while (payloadHex.length > totalIndex);

    }@catch(NSException *exception){
    //3:抛出异常
        [arr addObject:@[]];
        
    }@finally{
    //5:代码
    }
    
    return arr;
}

/**
 对蓝牙验证payload处理
 */
//MARK: 蓝牙数据payload处理
+(NSMutableArray *)authTLVPayloadTransfer:(NSString *)payloadHex{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    int index = 0;
    int totalIndex = 0;
    
    @try{
    //1:抛出异常的代码
    //2:代码
        do {
            BleProtocolFrameModel * model = [[BleProtocolFrameModel alloc] init];
            model.type = [payloadHex substringWithRange:NSMakeRange(index,4)];
            model.length = [payloadHex substringWithRange:NSMakeRange(4+index,2)];
            
            NSString *tenStr = [NSString stringWithFormat:@"%lu",strtoul([model.length UTF8String],0,16)];
            
            index = tenStr.intValue*2;
            
            model.value = [payloadHex substringWithRange:NSMakeRange(6+totalIndex,index)];
            
            index = index + 6;
            totalIndex = totalIndex + index;
            
            [arr addObject:model];
            
        } while (payloadHex.length > totalIndex);

    }@catch(NSException *exception){
    //3:抛出异常
        [arr addObject:@[]];
        
    }@finally{
    //5:代码
    }
        
    return arr;
}

/**
 对蓝牙验证payload处理
 */
//MARK: 蓝牙数据payload处理
+(NSMutableArray *)logTLVPayloadTransfer:(NSString *)payloadHex{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    int index = 0;
    int totalIndex = 0;
    
    @try{
    //1:抛出异常的代码
    //2:代码
        do {
            BleProtocolFrameModel * model = [[BleProtocolFrameModel alloc] init];
            model.type = [payloadHex substringWithRange:NSMakeRange(index,2)];
            model.length = [payloadHex substringWithRange:NSMakeRange(2+index,4)];
            
            NSString *tenStr = [NSString stringWithFormat:@"%lu",strtoul([model.length UTF8String],0,16)];
            
            index = tenStr.intValue*2;
            
            model.value = [payloadHex substringWithRange:NSMakeRange(6+totalIndex,index)];
            
            index = index + 6;
            totalIndex = totalIndex + index;
            
            [arr addObject:model];
            
        } while (payloadHex.length > totalIndex);

    }@catch(NSException *exception){
    //3:抛出异常
        [arr addObject:@[]];
        
    }@finally{
    //5:代码
    }
        
    return arr;
}


// MARK:  - 16位随机数
+(NSString *)randomString
{
    //随机数从这里边产生
    NSMutableArray *startArray=[[NSMutableArray alloc] initWithObjects:@"0", @"A", @"1", @"B", @"2", @"C", @"3", @"D", @"4", @"E", @"5",@"6",@"7", @"8",@"9", @"F",  nil];
    //随机数产生结果
    NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    NSInteger m=16;
    for (int i=0; i<m; i++) {
        int t=arc4random()%startArray.count;
        resultArray[i]=startArray[t];
        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    NSString *string = [resultArray componentsJoinedByString:@""];
    return string;
}

/**
 拼接成tlv字符串
 */
//MARK: 解析tlv
+(NSString *)tlvConstantsAdd:(int)type value:(NSString *)value{
    
    NSString *typeStr = [self ToHexSrtingByFillZero:type];
    NSInteger length = value.length/2;
    NSString *lengthStr = [self ToHexSrtingByFillZero:length];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",typeStr,lengthStr,value];
    return str;
}

+(NSMutableData *)tlvDataConstantsAdd: (Byte)type value: (NSMutableData*)valueData{
    
    NSMutableData* tlvData = [NSMutableData data];
    NSString *typeHexString = [self ToHexSrtingByFillZero:type];
    //    NSMutableData* valueData = [DigitalKeyTool convertHexStrToData:value];
    if (valueData) {
        int valueDataLength = (int)valueData.length;
        [tlvData appendData:[DigitalKeyTool convertHexStrToData:typeHexString]];        // T
        [tlvData appendData:[DigitalKeyTool convertHexStrToData:[DigitalKeyTool ToHex:valueDataLength]]]; // L
        [tlvData appendData:valueData];      // V
        return tlvData;
    }
    else {
        return nil;
    }
}

+(NSString *)toJsonStrWithDictionary:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSString class]]) {
        return (NSString *)dict;
    }
    NSError *parseError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonSrt = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (parseError) {
        jsonSrt = @"";
    }
    return jsonSrt;
}

/**
 设备ID 查询
 */
// MARK: 设备ID 查询
+(NSString *)getDeviceId{
    return @"123123";
//    NSString *uuid = [UUIDManager getDeviceID];
//    uuid = [uuid stringByReplacingOccurrencesOfString:@"-"withString:@""];
//    uuid = [uuid substringToIndex: 13];
//
////    NSString *icce = @"000000";//icce支持指示1byte   支持版本最低 最高 2byte
//
//    NSString *deviceId = uuid;//[NSString stringWithFormat:@"%@%@",icce,uuid];
//    deviceId = deviceId.dataBytez.sha2_256.toString;
//
//    if (deviceId.length > 32) {
//        deviceId = [deviceId substringToIndex: 32];;
//    }else{
//        deviceId = @"00000000000000000000000000000000";
//    }
//
//    return deviceId;
    
}


/**
 添加补80
 */
//MARK: 发指令补80
+(NSString *)bodyAddFill80:(NSString *)bodyString{
        
    if (bodyString.length < 32) {
        
        bodyString = [NSString stringWithFormat:@"%@80",bodyString];
        NSInteger leng = 32 - bodyString.length;
        for (int i = 0; i < leng/2; i++) {
            bodyString = [NSString stringWithFormat:@"%@00",bodyString];
        }
        
    }else if(bodyString.length < 64){
        
        bodyString = [NSString stringWithFormat:@"%@80",bodyString];
        NSInteger leng = 64 - bodyString.length;
        for (int i = 0; i < leng/2; i++) {
            bodyString = [NSString stringWithFormat:@"%@00",bodyString];
        }
        
    }else if(bodyString.length < 128){
        
        bodyString = [NSString stringWithFormat:@"%@80",bodyString];
        NSInteger leng = 128 - bodyString.length;
        for (int i = 0; i < leng/2; i++) {
            bodyString = [NSString stringWithFormat:@"%@00",bodyString];
        }
        
    }else if (bodyString.length < 256){
        
        bodyString = [NSString stringWithFormat:@"%@80",bodyString];
        NSInteger leng = 256 - bodyString.length;
        for (int i = 0; i < leng/2; i++) {
            bodyString = [NSString stringWithFormat:@"%@00",bodyString];
        }
        
    }
    
    return bodyString;
    
}


//MARK: 手机型号
+(NSString*) getDeviceModel {
    return @"asdasd";
//    NSString* modelInfo  = [[[UIDevice currentDevice]  modelVersion] stringByReplacingOccurrencesOfString:@"," withString:@""];
//    modelInfo = [self hexStringFromString:modelInfo];
//
//    if (modelInfo.length < 56) {
//
//        NSInteger index = 56 - modelInfo.length;
//        for (int i = 0; i < index/2; i++) {
//            modelInfo = [NSString stringWithFormat:@"%@ff",modelInfo];
//        }
//
//    }else{
//        modelInfo = [modelInfo substringToIndex:56];
//    }
    
    
//    NSString* modelInfo  = [[UIDevice currentDevice]  modelVersion];
//    return modelInfo;
    
}

//MARK: 手机品牌
+(NSString*) getManufacturer {
    
//    NSString* manufacturer = [self hexStringFromString:@"iPhone"];
//    manufacturer = [NSString stringWithFormat:@"%@ffffffffffff",manufacturer];
//    return manufacturer;
    return @"iPhone";
    
}

//MARK: - 返回一个字符传.跳转到设置页面蓝牙
+ (NSString *)getAppSettingBlue{
    
    NSString *setBlue = @"App";
    setBlue = [setBlue stringByAppendingFormat:@"-Pre"];
    setBlue = [setBlue stringByAppendingFormat:@"fs:"];
    setBlue = [setBlue stringByAppendingFormat:@"root"];
    setBlue = [setBlue stringByAppendingFormat:@"=Blu"];
    setBlue = [setBlue stringByAppendingFormat:@"eto"];
    setBlue = [setBlue stringByAppendingFormat:@"oth"];
    return setBlue;
    
}

/**
 获取当前时间
 */
+(NSString *)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;

}

/**
 *NSDate转字符串
 *@param str 日期数据源
 */
+(NSString *)dateLongFromString:(NSDate *)str{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *timeSp = [dateFormatter stringFromDate:str];
    //dateFromString NSData转化成字符串
    return timeSp;
}

/**
 是否ios 11.0及其以上版本
 */
+(BOOL)isSupportDigitalKey{
    return true;
}


@end
