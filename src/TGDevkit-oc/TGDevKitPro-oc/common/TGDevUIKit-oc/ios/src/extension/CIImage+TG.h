//
//  CIImage+TG.h
//  WeiShop
//
//  Created by toad on 2016/12/8.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIImage  (TG)
+ (CIImage *) imageWithQRString:(NSString *)qrString;
@end
