//
//  TGBundleUtile.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/15.
//

#import "TGBundleUtil.h"

@implementation TGBundleUtil

+ (id) loadNibNamed:(NSString *)name owner:(nullable id)owner options:(nullable NSDictionary<UINibOptionsKey, id> *)options bundle:(NSBundle *)bundle index:(NSUInteger)index{
    NSString *path = @"";
    NSBundle *tempBundle = NULL;
    if (NULL == bundle || ![bundle isKindOfClass:[NSBundle class]]) {
        tempBundle = [NSBundle mainBundle];
    }
    else {
        
    }
    path = [tempBundle pathForResource:name ofType:@"nib"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = false;
    BOOL isExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExists || isDirectory) {
        return NULL;
    }
    NSArray *nibArray = [tempBundle loadNibNamed:name owner:owner options:options];
    if (NULL != nibArray && nibArray.count > 0) {
        if (index < nibArray.count) {
            return nibArray[index];
        }
        else {
            return [nibArray firstObject];
        }
    }
    return NULL;
}

+ (id) loadNibNamed:(NSString *)name owner:(nullable id)owner options:(nullable NSDictionary<UINibOptionsKey, id> *)options{
    return [self loadNibNamed:name owner:owner options:NULL bundle:NULL index:0];
}

+ (id) loadNibNamed:(NSString *)name owner:(nullable id)owner{
    return [self loadNibNamed:name owner:owner];
}

@end
