//
//  TGFileList.m
//  TGCodeRows
//
//  Created by toad on 2022/05/11.
//

#import "TGFileList.h"
#import "APPConfig.h"

@implementation TGFileList

- (id) initWithPath:(NSString *)path{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSMutableArray<TGFileList *> *)subFile{
    if (!_subFile) {
        _subFile = [[NSMutableArray alloc] init];
    }
    return _subFile;
}

- (NSArray *)arrayWithPath:(NSString *)path{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = false;
    NSError *error = NULL;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
        APPConfig *config = [APPConfig getInstance];
        if (isDirectory) {
            self.isDirectory = isDirectory;
            if (![config.ignoreFolders containsObject:[path lastPathComponent]]) {
                NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:&error];
    //            [array addObject:@{
    //                @"isDirectory":@(true),
    //                @"Path":path
    //            }];
                for (NSString *fileName in contents) {
                    
                    [array addObjectsFromArray:[self arrayWithPath:[path stringByAppendingPathComponent:fileName]]];
                }
            }
        }
        else {
            NSString *extension = [[path pathExtension] lowercaseString];
            if (!config.checkFileTypes || ![config.checkFileTypes containsObject:extension]) {
            }
            else {
                [array addObject:path];
//                [array addObject:@{
//                    @"isDirectory":@(false),
//                    @"Path":path
//                }];
            }
        }
    };
    return array;
}

- (void) setPath:(NSString *)path{
    if (!path) {
        return;
    }
    _path = path;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = false;
    NSError *error = NULL;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            self.isDirectory = isDirectory;
            NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:nil];
            for (NSString *fileName in contents) {
                [path stringByAppendingPathComponent:fileName];
            }
        }
        else {
            
        }
    };
    
}

@end
