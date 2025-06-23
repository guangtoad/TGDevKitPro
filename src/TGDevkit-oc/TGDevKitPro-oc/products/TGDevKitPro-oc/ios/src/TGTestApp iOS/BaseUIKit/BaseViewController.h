//
//  BaseViewController.h
//  TGTestApp iOS
//
//  Created by toad on 2022/07/25.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Base)
- (void) showAlert:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler;
- (void) showAlertTitle:(NSString *)title message:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler;
@end

@interface BaseViewController : UIViewController

@end

@interface BaseTableViewController : UITableViewController

@end

@interface BaseNavigationController : UINavigationController

@end

@interface BaseTabBarController : UITabBarController

@end

NS_ASSUME_NONNULL_END
