//
//  DKViewController.h
//  DKTool
//
//  Created by toad on 2021/08/16.
//

#import <Cocoa/Cocoa.h>
#import "DKToolView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DKViewController : NSViewController
@property (nonatomic,strong) IBOutlet DKToolView *dkToolView;
@end

NS_ASSUME_NONNULL_END
