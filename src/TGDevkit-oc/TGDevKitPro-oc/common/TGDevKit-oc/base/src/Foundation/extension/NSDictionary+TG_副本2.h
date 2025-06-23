//
//  NSDictionary+TG.h
//  WeiShop
//
//  Created by toad on 16/5/17.
//  Copyright © 2016年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TG_NULL_VALUE_BOOL false
#define TG_NULL_VALUE_INT   -1
#define TG_NULL_VALUE_FLOAT -1
#define TG_NULL_VALUE_STR   @""
#define TG_NULL_VALUE_DOULE 0

@interface NSDictionary (TG)

- (NSString *) my_description;

- (id) clasModel:(Class)obj_class Key:(id)aKey;
- (NSString *) stringValueForKey:(id)aKey;
- (NSInteger) integerValueForKey:(id)aKey;
- (int) intForKey:(id)key;
- (float) floatValueForKey:(id)key;
- (double) doubleValueKey:(id)key;
- (BOOL) boolValueForKey:(id)key;

@end
