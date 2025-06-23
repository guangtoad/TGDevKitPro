//
//  TGFileItem.h
//  TGCodeRows
//
//  Created by toad on 2022/05/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGFileItem : NSObject

@property (nonatomic,strong) NSString *filePath;
@property (nonatomic,strong) NSString *row;
@property (nonatomic,strong) NSString *editRow;

@end

NS_ASSUME_NONNULL_END
