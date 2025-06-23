//
//  DKService.h
//  DKTool
//
//  Created by toad on 2021/08/13.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

@interface DKService : NSObject
@property (nonatomic,strong) CBService *service;
@end

NS_ASSUME_NONNULL_END
