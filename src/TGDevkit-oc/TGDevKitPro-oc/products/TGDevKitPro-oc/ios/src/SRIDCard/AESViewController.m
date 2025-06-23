//
//  AESViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/08/26.
//

#import "AESViewController.h"

#import <CommonCrypto/CommonCrypto.h>

@interface AESViewController ()

@end
//#define kCCKeySizeAES256 128

#define ELC_DB_ENCRYPTKEY @"f6c0975f2c742dbb487083ab5090da6f"
#define kCCBlockSizeAES128 128

const NSString *AESKey = @"abcdefghABCDEFGH";

// key跟后台协商一个即可，保持一致
static NSString *const PSW_AES_KEY = @"这里填写客户端跟后台商量的key";
// 这里的偏移量也需要跟后台一致，一般跟key一样就行
static NSString *const AES_IV_PARAMETER = @"偏移量";


@implementation NSString (AES)

- (NSString*)aci_encryptWithAES {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128operation:kCCEncrypt
                                       data:data
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    NSString *baseStr_GTM = [self encodeBase64Data:AESData];
    return baseStr_GTM;
}
 
- (NSString*)aci_decryptWithAES {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *baseData_GTM = [self decodeBase64Data:data];
    NSData *baseData = [[NSData alloc]initWithBase64EncodedString:self options:0];
    
    NSData *AESData_GTM = [self AES128operation:kCCDecrypt
                                           data:baseData_GTM
                                            key:PSW_AES_KEY
                                             iv:AES_IV_PARAMETER];
    NSData *AESData = [self AES128operation:kCCDecrypt
                                       data:baseData
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    
    NSString *decStr_GTM = [[NSString alloc] initWithData:AESData_GTM encoding:NSUTF8StringEncoding];
//    LYLog(@"decStr_GTM : %@",decStr_GTM);
    NSString *decStr = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
    
    return decStr;
}
 
/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 *
 *
 */
- (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    UInt8 key2;
    UInt8 iv2;
    
//    CCOptions(kCCAlgorithmAES);
//    CCCrypt(kCCEncrypt, kCCAlgorithmAES, kCCOptionPKCS7Padding, key2, 1, iv2, NULL, 2, NULL, 2, NULL);
    char keyPtr[kCCKeySizeAES128 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
        这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
    */
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        NSLog(@"Success");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}
 
// 这里附上GTMBase64编码的代码，可以手动写一个分类，也可以直接cocopods下载，pod 'GTMBase64'。
/**< GTMBase64编码 */
- (NSString*)encodeBase64Data:(NSData *)data {
//    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
 
/**< GTMBase64解码 */
- (NSData*)decodeBase64Data:(NSData *)data {
//    data = [GTMBase64 decodeData:data];
    return data;
    
}

@end

@interface AESViewController ()

@property (nonatomic,weak) IBOutlet UITextField *txtKey;
@property (nonatomic,weak) IBOutlet UITextField *txtIV;
@property (nonatomic,weak) IBOutlet UITextView *txtSource;
@property (nonatomic,weak) IBOutlet UITextView *txtDestination;

@end

@implementation AESViewController
- (NSString *)dataTohexString:(NSData*)data{
      Byte *bytes = (Byte *)[data bytes];
      NSString *hexStr=@"";
      for(int i=0;i<[data length];i++)
      {
          NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];//16进制数
          if([newHexStr length]==1)
              hexStr = [NSString        stringWithFormat:@"%@0%@",hexStr,newHexStr];
          else
              hexStr = [NSString       stringWithFormat:@"%@%@",hexStr,newHexStr];
      }
      return hexStr;
  }
- (NSData*)hexStringToData:(NSString*)hexString{
      int j=0;
      Byte bytes[hexString.length];  ///3ds key的Byte 数组， 128位
      for(int i=0;i<[hexString length];i++)
      {
          int int_ch;  /// 两位16进制数转化后的10进制数
          unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
          int int_ch1;
          if(hex_char1 >= '0' && hex_char1 <='9')
          int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
          else if(hex_char1 >= 'A' && hex_char1 <='F')
              int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
          else
              int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
          i++;
          unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
          int int_ch2;
          if(hex_char2 >= '0' && hex_char2 <='9')
              int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
          else if(hex_char1 >= 'A' && hex_char1 <='F')
              int_ch2 = hex_char2-55; //// A 的Ascll - 65
          else
              int_ch2 = hex_char2-87; //// a 的Ascll - 97
          int_ch = int_ch1+int_ch2;
          //NSLog(@"int_ch=%x",int_ch);
          bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
          j++;
      }
      //    NSData *newData = [[NSData alloc] initWithBytes:bytes length:j];
      NSData *newData = [[NSData alloc] initWithBytes:bytes length:j];
      //NSLog(@"newData=%@",newData);
      return newData;
  }
- (NSData *)AES128EncryptWithData:(NSData *)data key:(NSString *)key ivKey:(NSString *)ivkey{
     char keyPtr[kCCKeySizeAES256+1];
     bzero(keyPtr, sizeof(keyPtr));
     [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
     NSUInteger dataLength = [data length];
     size_t bufferSize = dataLength * 4 + kCCBlockSizeAES128;
     void *buffer = malloc(bufferSize);
     size_t numBytesEncrypted = 0;
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                           kCCOptionPKCS7Padding ,
                                           keyPtr, kCCBlockSizeAES128,
                                           [ivkey UTF8String],
                                           [data bytes], dataLength,
                                           buffer, bufferSize,
                                           &numBytesEncrypted);
     if (cryptStatus == kCCSuccess) {
         return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
     }
     free(buffer);
     return nil;
 }

//解密
- (NSData *)AES128DecryptWithData:(NSData *)data key:(NSString *)key ivkey:(NSString *)ivkey{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding ,
                                          keyPtr, kCCBlockSizeAES128,
                                          [ivkey UTF8String],
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}
//将string转成带密码的data
- (NSString*)encryptAESData:(NSString*)string Withkey:(NSString *)key ivkey:(NSString *)ivkey{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [self AES128EncryptWithData:data key:key ivKey:ivkey];
    //加密之后编码
    return [self dataTohexString:encryptedData];;
}

- (void) aesWith:(CCOperation)operation{
    if (self.txtKey.text.length < 1) {
        [self showAlert:@"没有KEY" handler:NULL];
        return;
    }
    if (self.txtIV.text.length < 1) {
        [self showAlert:@"没有IV" handler:NULL];
        return;
    }
    if (self.txtSource.text.length < 1) {
        [self showAlert:@"没有字" handler:NULL];
        return;
    }
//    NSData *sourceData = [[NSData alloc]initWithBase64EncodedString:self.txtSource.text options:0];
    NSString *decStr = [self encryptAESData:self.txtSource.text Withkey:self.txtKey.text ivkey:self.txtIV.text];
    self.txtDestination.text = decStr;
    
//    NSData *desData = [self.txtSource.text AES128operation:operation
//                                           data:sourceData
//                                            key:self.txtKey.text
//                                             iv:self.txtIV.text];
//
//    NSString *decStr = [self.txtSource.text encodeBase64Data:desData];
//    NSString *decStr = [[NSString alloc] initWithData:desData encoding:NSUTF8StringEncoding];
    
    self.txtDestination.text = decStr;
}
- (IBAction) click_Encerpyt:(id)sender{
    [self aesWith:kCCEncrypt];
}

- (IBAction) click_Dencerpyt:(id)sender{
    [self aesWith:kCCDecrypt];
}

+ (NSString *)aesEncrypt:(NSString *)sourceStr key:(NSString *)key{
    if (!sourceStr) {
        return nil;
    }
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
     
    NSData *sourceData = [sourceStr dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [sourceData length];
    size_t buffersize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(buffersize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [sourceData bytes], dataLength, buffer, buffersize, &numBytesEncrypted);
     
    if (cryptStatus == kCCSuccess) { 
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //对加密后的二进制数据进行base64转码
        return [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    } else {
        free(buffer);
        return nil;
    }
}
+ (NSString *) cryptKey{
    return ELC_DB_ENCRYPTKEY;
}
+ (NSData *)encrypt:(NSString *)string {

    return [string dataUsingEncoding:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));

    [[[self class] cryptKey] getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [data length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
            kCCOptionPKCS7Padding | kCCOptionECBMode,
            keyPtr, kCCBlockSizeAES128,
            NULL,
            [data bytes], dataLength,
            buffer, bufferSize,
            &numBytesEncrypted);
    NSData* result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return result;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
