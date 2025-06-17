//
//  TGFileUtil.h
//  TGFileUtil
//
//  Created by toad on 2021/08/30.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TGFileUtil : NSObject

+ (NSString *) documentPathWithFilePath:(NSString *)aPath;
+ (NSString *) pathWith:(NSString *)filePath basePath:(NSString *)basePath;

+ (NSString *) resourcePath:(NSString *)filePath bundle:(NSBundle *)bundle;
+ (NSString *) resourcePath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
