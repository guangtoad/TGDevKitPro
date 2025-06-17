//
//  TGFileUtil.m
//  TGFileUtil
//
//  Created by toad on 2021/08/30.
//

#import "TGFileUtil.h"

bool isNullValue(NSObject* obj,Class aClass){
    if (NULL != obj && [obj isKindOfClass:aClass]) {
        return true;
    }
    return false;
}

@implementation TGFileUtil

+ (NSString *) pathWith:(NSString *)filePath basePath:(NSString *)basePath{
    
    if (!isNullValue(filePath,[NSString class])){
        return NULL;
    }
    if ([filePath isAbsolutePath]) {
        return filePath;
    }
    if (!isNullValue(basePath,[NSString class])){
        return filePath;
    }
    return [basePath stringByAppendingPathComponent:filePath];
}

+ (NSString *) documentPathWithFilePath:(NSString *)aPath{
    return [self pathWith:aPath basePath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
}

+ (NSString *) resourcePath:(NSString *)filePath bundle:(NSBundle *)bundle{
    if (isNullValue(bundle, [NSBundle class])) {
        return [self pathWith:filePath basePath:[bundle resourcePath]];
    }
    else {
        return [self pathWith:filePath basePath:[[NSBundle mainBundle] resourcePath]];
    }
}

+ (NSString *) resourcePath:(NSString *)filePath{
    return [self resourcePath:filePath bundle:NULL];
}
@end
