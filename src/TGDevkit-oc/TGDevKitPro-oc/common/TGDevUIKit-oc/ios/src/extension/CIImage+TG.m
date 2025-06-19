//
//  CIImage+TG.m
//  WeiShop
//
//  Created by toad on 2016/12/8.
//  Copyright © 2016年 toad. All rights reserved.
//

#import "CIImage+TG.h"

@implementation CIImage (TG)

+ (CIImage *) imageWithQRString:(NSString *)qrString{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}
 
@end
