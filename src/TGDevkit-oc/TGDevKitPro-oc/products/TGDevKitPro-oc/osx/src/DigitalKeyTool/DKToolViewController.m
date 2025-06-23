//
//  ViewController.m
//  DKTool
//
//  Created by toad on 2021/08/13.
//

#import "DKToolViewController.h"
#import "NSData+TG.h"

#import "NSData+UAESUntil.h"
#import "NSString+UAESUntil.h"
#import "DigitalKeyTool.h"

@implementation DKToolViewController

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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
