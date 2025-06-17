//
//  TGImage.h
//  TGDevelopToolsApp
//
//  Created by toad on 2023/12/27.
//

#import "TGKit-prefix.pch"

#if TARGET_OS_IOS
@interface TGImage : UIImage

@end
#elif TARGET_OS_OSX
@interface TGImage : NSImage

@end
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TGImage()

@end

NS_ASSUME_NONNULL_END
