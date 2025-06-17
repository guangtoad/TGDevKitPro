//
//  TGLogge.h
//  TG-ObjC
//
//  Created by toad on 2019/5/27.
//  Copyright © 2019 toad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGLog.h"

@interface TGLogger : NSObject

@property (nonatomic,strong) NSMutableArray<TGLog *> *logs;

@end

