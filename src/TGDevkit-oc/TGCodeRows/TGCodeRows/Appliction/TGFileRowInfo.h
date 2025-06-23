//
//  TGFileRowInfo.h
//  TGCodeRows
//
//  Created by toad on 2022/05/25.
//

#import <Foundation/Foundation.h>
#import "TGFileItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGFileRowInfo : NSObject

@property (nonatomic,strong) NSMutableArray <TGFileItem *> *fileItems;

@end

NS_ASSUME_NONNULL_END
