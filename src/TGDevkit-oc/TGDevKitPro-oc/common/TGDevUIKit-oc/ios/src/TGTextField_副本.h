//
//  TGTextField.h
//  TG Develop Tools ios
//
//  Created by toad on 2023/11/2.
//

NS_ASSUME_NONNULL_BEGIN
#if TARGET_OS_IOS
@interface TGTextField : UITextField

@end
#elif TARGET_OS_OSX
@interface TGTextField : NSTextField

@end
#else
    #error unknow OS
#endif

@interface TGTextField()
@end
NS_ASSUME_NONNULL_END
