//
//  TGFileRowInfo.m
//  TGCodeRows
//
//  Created by toad on 2022/05/25.
//

#import "TGFileRowInfo.h"

@implementation TGFileRowInfo

- (NSMutableArray<TGFileItem *> *)fileItems{
    if (!_fileItems) {
        _fileItems = [[NSMutableArray<TGFileItem *> alloc] init];
    }
    return _fileItems;
}

@end
