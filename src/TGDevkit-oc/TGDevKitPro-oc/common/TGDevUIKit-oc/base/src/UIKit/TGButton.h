//
//  TGButton.h
//  TGObj
//
//  Created by toad on 15/9/22.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+TG.h"

#if TARGET_OS_IOS
@interface TGButton : UIButton

@end
#elif TARGET_OS_OSX
@interface TGButton : NSButton

@end
#else
    #error unknow OS
#endif

@interface TGButton()
@end
