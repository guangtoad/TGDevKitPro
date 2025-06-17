//
//  StringUtilityViewController.h
//  TGHelperAPP
//
//  Created by toad on 2022/07/19.
//

#import <Cocoa/Cocoa.h>
#import <TGFoundation/TGFoundation.h>
//#import <TGFoundation/NSString+TGCodec.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringUtilityViewController : NSViewController

@property (nonatomic,strong) IBOutlet NSTextField *inputText;
@property (nonatomic,strong) IBOutlet NSTextField *outputText;

@end

NS_ASSUME_NONNULL_END
