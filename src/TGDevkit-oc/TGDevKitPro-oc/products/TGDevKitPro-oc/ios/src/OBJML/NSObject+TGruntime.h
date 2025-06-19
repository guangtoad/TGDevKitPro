//
//  NSObject+RunTime.h
//  ObjCDome
//
//  Created by toad on 2017/11/23.
//  Copyright © 2017年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
@interface NSObject (TGruntime)

- (id) getValueName:(NSString *)name;

+ (NSArray *)getAllIvar;
- (NSArray *)getAllIvar;

@end
