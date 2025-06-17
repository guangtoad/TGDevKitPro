//
//  UIImageView+TG.m
//  TG
//
//  Created by home on 2018/5/11.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "UIImageView+TG.h"
#import "UIimage+TG.h"

@implementation UIImageView (TG)

/**
 @brief base64 to image

 @param base64 base64
 */
- (void) setImageWithBase64:(NSString *)base64{
    UIImage *image = [UIImage imageWithBase64String:base64];
    [self setImage:image];
}

@end
