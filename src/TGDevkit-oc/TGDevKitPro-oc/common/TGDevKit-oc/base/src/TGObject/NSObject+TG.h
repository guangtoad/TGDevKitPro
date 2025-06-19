//
//  NSObject+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_include(<objc/runtime.h>)
#import <objc/runtime.h>
#define __openRunTime       true
#else
#define __openRunTime       false
#endif

@interface NSObject (NSDictionary)

- (NSString *) toString;
- (NSDictionary *) toDictionary;
+ (NSDictionary *) toDictionary;

- (id) initFromDictionary:(NSDictionary *)dictionary;

@end

@interface NSObject (UIKeyboardNotification)

- (void) keyboardWillShowNotification:(NSNotification *)note;
- (void) keyboardWillHideNotification:(NSNotification *)note;

- (void) addKeyboardResponderObserver;
- (void) removeKeyboardResponderObserver;

@end

@interface NSObject (TG)

+ (id) sharedInstance;

@end
