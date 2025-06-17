//
//  TGView.h
//  TGDevelopToolsApp
//
//  Created by toad on 2023/12/27.
//

#import "TGKit-prefix.pch"

NS_ASSUME_NONNULL_BEGIN
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
NS_ASSUME_NONNULL_END
