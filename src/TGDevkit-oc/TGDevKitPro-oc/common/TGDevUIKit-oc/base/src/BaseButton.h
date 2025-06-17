//
//  BaseButton.h
//  TGDevelopToolsApp
//
//  Created by toad on 2023/12/26.
//


#if TARGET_OS_IOS
@interface BaseButton : UIButton

@end
#elif TARGET_OS_OSX
@interface BaseButton : NSButton

@end
#else
    #error unknow OS
#endif

NS_ASSUME_NONNULL_BEGIN



NS_ASSUME_NONNULL_END
