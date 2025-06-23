//
//  UIColor+TG.h
//  TGobj
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TG)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define TGHEXCOLOR(__HEX) [UIColor colorWithHexString:__HEX]
