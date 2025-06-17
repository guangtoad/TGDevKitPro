//
//  UIViewController+Alert.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Alert)

- (void) showAlert:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler;
- (void) showAlertTitle:(NSString *)title message:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler;
@end

NS_ASSUME_NONNULL_END
