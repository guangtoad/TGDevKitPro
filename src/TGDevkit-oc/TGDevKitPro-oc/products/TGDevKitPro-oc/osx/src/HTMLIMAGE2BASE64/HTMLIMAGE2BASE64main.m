//
//  main.m
//  TGToo
//
//  Created by home on 2017/12/26.
//  Copyright © 2017年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HtmlImageToBase64.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"start:1");
        NSURL *urlStr = @"http://192.168.1.130/LevelThreeWarningWeb/LevelThreeWarningHandle.aspx ";
        for (int i = 0 ; i < 50 ; i++){
            NSThread *thuread = [[NSThread alloc] initWithBlock:^{
                for (int i = 0 ; i < 100; i++ ){
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];

                    request.HTTPMethod = @"POST";

                    NSString *xml = [NSString stringWithFormat:@"<PHVALARM>                                     <VIN>JTHBN36FX65046152</VIN>                                     <OCCURDAT>20181115171650</OCCURDAT>                                     <OCCURLAT>123</OCCURLAT>                                     <OCCURLON>124</OCCURLON>                                     <ALARMTYPE>3</ALARMTYPE>                                     <ALARMCONTENT>阿斯利康发动机11111111111111111111111</ALARMCONTENT>                                     <DATUM></DATUM>                                     </PHVALARM>"];
                    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];

                    [request setHTTPBody:body];

                    NSURLSession *session = [NSURLSession sharedSession];
                    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {}];
                }
            }
            [thuread start];
        }
        // insert code here...
        //[HtmlImageToBase64 openFileSeler];
    }
    return 0;
}
