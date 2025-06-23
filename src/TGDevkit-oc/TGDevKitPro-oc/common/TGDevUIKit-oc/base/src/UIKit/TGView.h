//
//  TGView.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TG.h"
#if TARGET_OS_IOS
@interface TGView : UIView

@end
#elif TARGET_OS_OSX
@interface TGView : NSView

@end
#else
    #error unknow OS
#endif

@interface TGView ()
@end
