//
//  MainSplitViewController.h
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import <Cocoa/Cocoa.h>
#import "APPUIKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainSplitViewController : NSSplitViewController<MenuTableViewDelegate>

@property (nonatomic,weak) IBOutlet NSSplitViewItem *leftViewItem;
@property (nonatomic,weak) IBOutlet NSSplitViewItem *rightViewItem;

@end

NS_ASSUME_NONNULL_END
