//
//  TGShareManageCenter.h
//  TGSahre
//
//  Created by home on 2018/4/14.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TGShareMacros.h"
#import "TGShareEnum.h"

@interface TGShareManageCenter : NSObject

- (void) registerSDK;

- (void) to:(TGShareToType)type
        url:(NSString *)urlStr
      title:(NSString *)title
    context:(NSString *)context
      image:(UIImage *)image;

+ (BOOL) showShareView;

@end
