//
//  X509Certificate.m
//  TG_macOS
//
//  Created by home on 2018/4/28.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "X509Certificate.h"

@implementation X509Certificate

-(NSString *)certifacateConvertToX509withoption:(NSInteger)Number andSerialNumber:(NSString *)serialNumber

{

    //DER证书缓冲区数组

    unsigned char usrCertificate[4096];

    //证书长度

    unsigned long usrCertificateLen;

    //X509证书结构体，保存证书

    X509 *usrCert;

    const unsigned char *pTmp = NULL;



    //根据证书序列号判断转换哪一张证书 serialNumber如果为空 正常执行

    if(serialNumber != NULL)

    {

        NSString *cerInfo =  [SFHFKeychainUtils getPasswordForUsername:@"key" andServiceName:@"cn.com.szca.tp" error:nil];

        if(cerInfo == NULL)

        {

            NSLog(@"证书文件为空，请重新申请证书");

            return NO;

        }

        NSData* jsondata=[cerInfo dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:nil];

        NSArray *jsonarr = [json objectForKey:@"key"];

        NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc]init];

        for(int i = 0; i < [jsonarr count]; i++)

        {

            NSDictionary *dictionary = [jsonarr objectAtIndex:i];

            jsonDic =[dictionary objectForKey:serialNumber];

            if(jsonDic != NULL)

            {

                break;

            }

        }

        if(jsonDic == NULL)

        {

            NSLog(@"序列号错误");

            return NO;

        }

        NSString *cerstr = [jsonDic objectForKey:@"certificate"];

        NSMutableData *decoData = [[NSMutableData alloc]initWithData:[self dataWithBase64EncodedString:cerstr]];

        [decoData writeToFile:RSACertificateFile atomically:YES];

    }



    //读取证书

    FILE *fp=fopen([RSACertificateFile cStringUsingEncoding:NSASCIIStringEncoding],"rb");

    if(fp==NULL)

    {

        printf("open file err\n");

        _verifyErrorMessge = @"证书文件打开失败";

        return nil;

    }

    usrCertificateLen = fread(usrCertificate,1,4096,fp);

    fclose(fp);



    pTmp=usrCertificate;

    // 判断是否为DER格式的数字证书

    usrCert = d2i_X509(NULL,&pTmp,usrCertificateLen);

    if(usrCert==NULL)

    {

        BIO *b;

        // 判断是否为PEM格式的数字证书

        b=BIO_new_file([RSACertificateFile cStringUsingEncoding:NSASCIIStringEncoding],"r");

        usrCert=PEM_read_bio_X509(b,NULL,NULL,NULL);

        //X509_print(b, usrCert);

        BIO_free(b);

        if(usrCert==NULL)

        {

            _verifyErrorMessge = @"证书解析失败";

            return nil;

        }

    }

    //X509结构写入文件

    FILE *filex509;

    filex509 = fopen([RSAX509File cStringUsingEncoding:NSASCIIStringEncoding],"w");

    PEM_write_X509(filex509, usrCert);

    fclose(filex509);



    //X509转化为RSA结构

    EVP_PKEY *pkey = X509_get_pubkey(usrCert);

    rsa_verify = pkey->pkey.rsa;

    if(rsa_verify == NULL)

    {

        _verifyErrorMessge = @"证书解析失败";

    }

    _deatailInfor = [self tGetX509Info:usrCert withoption:Number];

    return _deatailInfor;

}
@end
