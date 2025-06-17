//
//  TGMacro.h
//  smartGLink_cn
//
//  Created by toad on 2018/5/3.
//  Copyright © 2018年 toad. All rights reserved.
//

#ifndef TGMacro_h
#define TGMacro_h


#endif /* TGMacro_h */

#define auto_delloc(__value) \
if (__value != nil) {\
[__value release]; \
__value = nil;}\

#if DEBUG == 1
#define TGLog(...) NSLog(__VA_ARGS__)
#define TGInfo(format, ...) NSLog((@"\nFile:%s" "\nFunction:%s" "\nLen:%d" "\nInfo:" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define TGWarn(format, ...) NSLog((@"Warning:" format), ##__VA_ARGS__);
#else
#define TGLog(...) {}
#define TGInfo(...) {}
#define TGWarn(...) {}
#endif
