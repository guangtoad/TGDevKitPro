//
//  UIImage+TG.m
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "UIImage+TG.h"

#import "CIImage+TG.h"

@implementation UIImage (TG)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect= CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGSize size = CGSizeMake(1.0f, 1.0f);
    return [self imageWithColor:color size:size];
}
+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert size:(CGSize)size{
    UIColor *color = [UIColor colorWithHexString:stringToConvert];
    return [self imageWithColor:color size:size];
}
+ (UIImage *) imageWithColroHexString:(NSString *)stringToConvert{
    UIColor *color = [UIColor colorWithHexString:stringToConvert];
    return [self imageWithColor:color];
}
+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image{
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    
    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width, image.extent.size.height));
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
+ (UIImage *) imageWithQRString:(NSString *)qrString{
    return [self createNonInterpolatedUIImageFromCIImage:[CIImage imageWithQRString:qrString]];
}

@end
