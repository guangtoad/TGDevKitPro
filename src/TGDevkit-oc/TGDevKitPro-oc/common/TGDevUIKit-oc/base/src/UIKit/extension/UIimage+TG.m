//
//  UIimage+TG.m
//  TG
//
//  Created by home on 2018/5/11.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "UIimage+TG.h"
#import "UIColor+TG.h"

@implementation UIImage (TGSize)

- (UIImage *) scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end

@implementation UIImage (TGColor)

/**
 @brief 生成单色图片

 @param color color
 @param size size
 @return image
 */
+ (UIImage *) imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect= CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 @brief 生成单色图片

 @param color color
 @return image size 1*1
 */
+ (UIImage *) imageWithColor:(UIColor *)color{
    CGSize size = CGSizeMake(1.0f, 1.0f);
    return [self imageWithColor:color size:size];
}

/**
 @brief 生成单色图片

 @param stringToConvert 16进制颜色编码
 @param size size
 @return image
 */
//+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert size:(CGSize)size{
//    UIColor *color = [UIColor colorWithHexString:stringToConvert];
//    return [self imageWithColor:color size:size];
//}

/**
 @brief 生成单色图片

 @param stringToConvert 16进制颜色编码
 @return image 1 * 1
 */
//+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert{
//    UIColor *color = [UIColor colorWithHexString:stringToConvert];
//    return [self imageWithColor:color size:CGSizeMake(1.0, 1.0)];
//}

/**
 @brief CGimage to Image

 @param image CGImage
 @return image;
 */
+ (UIImage *) createNonInterpolatedUIImageFromCIImage:(CIImage *)image{
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];

    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width, image.extent.size.width));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixel-correct image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return scaledImage;
}

@end

@implementation UIImage (TGBase64)

+ (nullable UIImage *) imageWithBase64String:(NSString *)base64Str{
    if (base64Str != nil) {
        //UI_USER_INTERFACE_IDIOM()
        NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
        //    NSData *data = [[NSData alloc] initWithBase64Encoding:base64Str];
        return [UIImage imageWithData:data];
    }
    return nil;
}

@end
