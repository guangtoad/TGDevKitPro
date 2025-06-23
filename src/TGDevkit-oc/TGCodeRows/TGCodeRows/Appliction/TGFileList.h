//
//  TGFileList.h
//  TGCodeRows
//
//  Created by toad on 2022/05/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGFileList : NSObject

- (id) initWithPath:(NSString *)path;

@property (nonatomic,strong) NSMutableArray<TGFileList *> *subFile;
@property (nonatomic,strong) NSString *path;
@property (nonatomic,assign) BOOL isDirectory;
@property (nonatomic,assign) NSUInteger fileCount;
- (NSArray *)arrayWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
