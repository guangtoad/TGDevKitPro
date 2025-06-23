//
//  UIImage+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+TG.h"

@interface UIImage (TG)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert size:(CGSize)size;
+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert;
+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image;
+ (UIImage *) imageWithQRString:(NSString *)qrString;

@end
