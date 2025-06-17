//
//  TGButton.h
//  TG Develop Tools ios
//
//  Created by toad on 2023/11/2.
//


#import "TGKit-prefix.pch"

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
