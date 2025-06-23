//
//  NSDictionary+TG.h
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TG_Json)
- (NSString *) jsonStr;
@end

@interface NSDictionary (TG)

- (_Nullable id) objectForKey:(id _Nonnull)aKey ClassModel:(Class _Nonnull)obj_class;

- (NSInteger) integerForKey:(id _Nonnull)key defValue:(NSInteger)def;
- (NSInteger) integerForKey:(id _Nonnull)key;

- (int) intForKey:(id)key defValue:(int)def;
- (int) intForKey:(id)key;

- (NSString * _Nullable) stringForKey:(id)key defValue:(NSString * _Nullable)def;
- (NSString * _Nullable) stringForKey:(id)key;

- (float) floatForKey:(id _Nonnull)key defValue:(float)def;
- (float) floatForKey:(id _Nonnull)key;

- (double) doubleForKey:(id _Nonnull)key defValue:(double)def;
- (double) doubleForKey:(id _Nonnull)key;

@end
