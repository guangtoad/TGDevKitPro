//
//  UIimage+TG.h
//  TG
//
//  Created by home on 2018/5/11.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TGSize)

- (UIImage *) scaleToSize:(CGSize)size;

@end

@interface UIImage (TGColor)

/**
 @brief 生成单色图片

 @param color color
 @param size size
 @return image
 */
+ (UIImage *) imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 @brief 生成单色图片

 @param color color
 @return image size 1*1
 */
+ (UIImage *) imageWithColor:(UIColor *)color;

///**
// @brief 生成单色图片
//
// @param stringToConvert 16进制颜色编码
// @param size size
// @return image
// */
//+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert size:(CGSize)size;

///**
// @brief 生成单色图片
//
// @param stringToConvert 16进制颜色编码
// @return image 1 * 1
// */
//+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert;

/**
 @brief CGimage to Image

 @param image CGImage
 @return image;
 */
+ (UIImage *) createNonInterpolatedUIImageFromCIImage:(CIImage *)image;


@end

@interface UIImage (TGBase64)

/**
 @brief base64 to image
 
 @param base64Str base64字符串
 @return image
 */
+ (nullable UIImage *) imageWithBase64String:(NSString *)base64Str;

@end
