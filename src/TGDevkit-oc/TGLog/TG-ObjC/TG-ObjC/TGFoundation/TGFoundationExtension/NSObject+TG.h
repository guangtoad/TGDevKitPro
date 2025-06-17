//
//  NSObjet+TG.h
//  TGObj
//
//  Created by toad on 15/9/21.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSObject (TG_runtime)

+ (NSString *) typeWithConvertFromObjc_property_t:(objc_property_t)property;

@end

@interface NSObject (TG_Dictionary)

- (NSDictionary *) dictionaryValue;

@end

@interface NSObject (TG_Sqlite)

@end

/**
 NSObject Coding 扩展
 */
@interface NSObject (TGCoding)

/**
 
 通过路径解码

 @param filePath 文件路径
 @return 实例
 */
+ (id) unarchiveObjectFromFilePath:(NSString *)filePath API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) ;

/**
 编码并保存到指定路径

 @param filePath 路径s
 @return 是否成功
 */
- (BOOL) archivedToFilePath:(NSString *)filePath API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0));

@end
