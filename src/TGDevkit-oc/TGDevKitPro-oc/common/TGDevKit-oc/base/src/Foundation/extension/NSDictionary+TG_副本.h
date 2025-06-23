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
- (id) objectForKey:(id)aKey ClassModel:(Class)obj_class;
- (NSInteger) getIntergerValueForKey:(id)akey;
- (int) getIntValueForKey:(id)aKey;
- (NSString *) getStringValueForKey:(id)aKey;
- (BOOL) getBoolValueForKey:(id)aKey;
- (NSDictionary *) getDictionaryValueForKey:(id)aKey;
@end
