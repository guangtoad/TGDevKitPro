//
//  main.m
//  OBJML
//
//  Created by toad on 2017/11/17.
//  Copyright © 2017年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextObj.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int testNum = 3.7999;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        
        formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        
        NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt: testNum]];
        
        NSLog(@"string:%@",string);
        // insert code here...
        NSLog(@"Hello, World!");
        TextObj *obj = [[TextObj alloc] init];
        [obj textObj];
        NSDateFormatter * selectedformmater = [[NSDateFormatter alloc] init];
        NSString *selectStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:00",(long)2017,(long)12,(long)12,(long)12];
        NSLog(@"selectStr:%@",selectStr);
        selectedformmater.dateFormat = @"yyyy-MM-dd HH:mm";
        NSDate *selectedDate = [selectedformmater dateFromString:selectStr];
        NSLog(@"selectedDate：%@",selectedDate);
    }
    return 0;
}
