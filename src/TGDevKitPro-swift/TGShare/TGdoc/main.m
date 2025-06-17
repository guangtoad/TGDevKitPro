//
//  main.m
//  TGdoc
//
//  Created by home on 2018/4/18.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_INLINE NSString *ElC_XML(NSString *xml){
//    return str;
//}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        @try {
//             http://www.abc.com/XXXX.aspx?a=aaaa&b=bbbbb&apptag=be77e4826729e45486c46b30f9e39e47
//            NSString *url = @"http://www.abc.com/XXXX.aspx?a=aaaa&b=bbbbb&apptag=be77e4826729e45486c46b30f9e39e47";
            NSString *url = @"http://192.168.1.171/shareTest/description.html?a=aaaa&b=bbbbb&apptag=be77e4826729e45486c46b30f9e39e47";
//            NSString *reg = @"(http[s]{0,1}://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";

            NSString *reg = @"(http[s]{0,1})://192.168.1.171/shareTest/([a-zA-Z0-9]+).(aspx|html)((\\?|&)(((a=[a-zA-Z0-9]+)|(b=[a-zA-Z0-9]+)|(apptag=[a-zA-Z0-9]+)))){3}";
            NSLog(@"reg:%@",reg);
//            NSString *reg = @"^(http[s]{0,1}://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
            NSString *regex = @"(http[s]{0,1}://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
            bool ret = [predicate evaluateWithObject:url];
            NSLog(@"ret:%@",@(ret));
        }

        @catch (NSException *exception) {
            NSLog(@"exc:%@",exception);
        }

    }
    return 0;
}
