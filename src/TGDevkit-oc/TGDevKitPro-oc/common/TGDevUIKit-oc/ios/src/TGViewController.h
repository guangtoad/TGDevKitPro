//
//  TGViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#import "TGView.h"
#import "TGImage.h"
#import "TGImageView.h"
#import "TGTextField.h"

NS_ASSUME_NONNULL_BEGIN
#if TARGET_OS_IOS
@interface TGViewController : UIViewController

@end
#elif TARGET_OS_OSX
@interface TGViewController : NSViewController

@end
#else
    #error unknow OS
#endif
@interface TGViewController()

@property (nonatomic,strong) NSMutableArray *dataSource;

@end



NS_ASSUME_NONNULL_END
