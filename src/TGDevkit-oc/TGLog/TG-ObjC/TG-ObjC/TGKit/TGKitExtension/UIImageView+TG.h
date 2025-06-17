//
//  UIImageView+TG.h
//  TG
//
//  Created by home on 2018/5/11.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TG)

/**
 @brief base64 to image

 @param base64 base64
 */
- (void) setImageWithBase64:(NSString *)base64;

@end
