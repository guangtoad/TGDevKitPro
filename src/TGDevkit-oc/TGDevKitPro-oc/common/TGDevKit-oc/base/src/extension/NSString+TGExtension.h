//
//  NSString+TGExtension.h
//  TG
//
//  Created by toad on 2018/4/25.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+TGEncrypt.h"
#import "NSString+TGRegex.h"

@interface NSString (TGExtension)

- (NSDate *) dateWithFormatter:(NSString *)formatterStr;

@end
