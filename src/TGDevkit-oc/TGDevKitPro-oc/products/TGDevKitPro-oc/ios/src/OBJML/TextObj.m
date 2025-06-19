//
//  TextObj.m
//  ObjCDome
//
//  Created by toad on 2017/11/17.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "TextObj.h"
#import "RACMacros.h"
#import "NSObject+TGRunTime.h"
@interface TextObj ()
/*! @brief This property knows my name. */
@property (nonatomic,strong) NSString *strtt222;
@end
#define STNAME(a) #a
#import <objc/runtime.h>

@interface TextObj (){
    
}
@property (nonatomic,strong) NSString *bb;
@property (nonatomic,strong) NSString *asd;
@end
@implementation TextObj

/**
 @brief tete
 入力
 @code
 
 @endcode
 出力
 @code
 
 @endcode
 @return sdfdd
 */
- (NSString *)tete{
        return @"";
}
- (CGRect) rect{
    return CGRectZero;
}

- (CGSize) size{
    return CGSizeZero;
}
- (CGFloat) cgfloat{
    return 0;
}
- (float) ff{
    return 0;
}
- (NSInteger) it{
    return 0;
}
- (int) ii{
    return 0;
}
- (long) lo{
    return 0;
}

- (void) textObj{
    NSString *errorCode = @"123456789";
    NSString *s = [errorCode substringWithRange:NSMakeRange(errorCode.length - 3, 3)];
    [self getValueName:@"lo"];
    NSLog(@"it");
    [self getValueName:@"it"];
    NSLog(@"ii");
    [self getValueName:@"ii"];
    NSLog(@"ff");
    [self getValueName:@"ff"];
    NSLog(@"cgfloat");
    [self getValueName:@"cgfloat"];
    NSLog(@"size");
    [self getValueName:@"size"];
    NSLog(@"rect");
    [self getValueName:@"rect"];
    NSLog(@"s");
    [self getValueName:@"tete"];
    
    return;
    SEL sel = sel_getUid([@"tete" UTF8String]);
    Method method = class_getInstanceMethod([TextObj class], @selector(tete));
    char *c = method_copyReturnType(method);
    if (method != nil) {
        char *c = method_copyReturnType(method);
        NSLog(@"c--》:%s",c);
        switch (c[0]) {
            case 'i':{
                NSLog(@"case i");
                break;
            }
            case '@':{
                NSLog(@"case @");
                break;
            }
            default:
                break;
        }
//    [self getInstanceMethod:@selector(bb)];
    return;
//    NSString *abc;
//    NSMutableString *sar = [[NSMutableString alloc] init];
//    [sar appendString:@"[[NSArray alloc] initWithObjects:"];
//    for (int i = 0 ; i < 24; i++) {
//        [sar appendFormat:@"@\"%d:00\",",i];
//    }
//    [sar appendFormat:@"nil];"];
//    NSLog(@":\n%@",sar);
//    NSLog(@"STNAME(abc):|%@|",@STNAME(abc));
//    
//    NSLog(@"aaa:%@",[NSString stringWithFormat:@"<%@>%@</%@>",@STNAME(abc),abc,@STNAME(abc)]);
////    NSLog(@"metamacro_stringify_(strtt):|%@|",metamacro_nsstrstringif(strtt));
//    NSLog(@"@keypath(strtt):|%@|",@keypath(self,strtt));
//    NSLog(@"@keypath(strtt):|%@|",@keypath(self,strtt222));
////    [self textObj];
    
}
}

@end


