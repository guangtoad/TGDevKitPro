//
//  TGHelper.h
//  WeiShop
//
//  Created by toad on 16/7/7.
//  Copyright © 2016年 toad. All rights reserved.
//

#ifndef TGHelper_h
#define TGHelper_h


#endif /* TGHelper_h */

#import <Foundation/Foundation.h>

NS_INLINE NSString *sizeToString(unsigned long long size){
    double tempSize = size;
    int i = 0;
    char sizeTyp = 0;
    for (; i < 4 && tempSize  >= 1024; i++) {
        tempSize = tempSize / 1024;
    }
    switch (i) {
        case 0: sizeTyp = 0; break;
        case 1: sizeTyp = 'K'; break;
        case 2: sizeTyp = 'M'; break;
        case 3: sizeTyp = 'G'; break;
        default: sizeTyp = 'T'; break;
    }
    return [NSString stringWithFormat:@"%.2f%cB",tempSize,sizeTyp];
}


#import <mach/mach_time.h>
NS_INLINE CGFloat BNRTimeBlock (void (^block)(void)) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    
    return (CGFloat)nanos / NSEC_PER_SEC;
}
NS_INLINE CGFloat PrintBNRTimeBlock(const char *name,void (^block)(void)){
    float runTime = BNRTimeBlock(block);
    printf("fun:%s--->run time = %f\n",name,runTime);
    return runTime;
}
