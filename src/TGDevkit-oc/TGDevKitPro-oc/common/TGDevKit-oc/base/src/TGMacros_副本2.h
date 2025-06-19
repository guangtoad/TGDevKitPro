//
//  TMacros.h
//  JGZ
//
//  Created by toad on 13-4-1.
//  Copyright (c) 2013年 toad. All rights reserved.
//

#import "TGMath.h"

#ifndef JGZ_TMacros_h
#define JGZ_TMacros_h

#if !defined(DEBUG)
#define DEBUG 0
#endif
#if DEBUG == 0
#define TGLOGFUN() do {} while (0)
#define TGLOG(...) do {} while (0)
#define TGLOGINFO(...) do {} while (0)
#define TGLOGERROR(...) do {} while (0)

#elif DEBUG == 1
#define TGLOGFUN() NSLog(@"%s(%d)" , __PRETTY_FUNCTION__,__LINE__)
#define TGLOG(...) NSLog(__VA_ARGS__)
#define TGLOGERROR(...) NSLog(__VA_ARGS__)
#define TGLOGINFO(...) TGLOG(__VA_ARGS__)

#elif DEBUG > 1
#define TGLOGFUN() NSLog(@"%s(%d)" , __PRETTY_FUNCTION__,__LINE__)
#define TGLOG(...) NSLog(__VA_ARGS__)
#define TGLOGERROR(...) NSLog(__VA_ARGS__)
#define TGLOGINFO(xx, ...) NSLog(@"%s(%d):\n " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

//-fno-objc-arc
#if ! __has_feature(objc_arc)
#define TGAutorelease(__v)      ([__v autorelease])
#define TGRetain(__v)           ([__v retain])
#define TGRelease(__v)           ([__v release])

#define TGRetainCount(__v)      ([__v retainCount])
#define TGDealloc               ([super dealloc])
#define TGCopy(__v)             ([__v copy])
#else
// -fobjc-arc

#define TGAutorelease(__v)      (__v)
#define TGRetain(__v)           (__v)
#define TGRelease(__v)           (__v)

#define TGRetainCount(__v)      (__v)
#define TGDealloc               {}
#define TGCopy(__v)             (__v)
#endif

#endif

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)


// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

#define NULLSTR(__str__) (!__str__?@"":__str__)

#define REMOVESRTTHE(__str__,__removeStr__)     [__str__ stringByReplacingOccurrencesOfString:__removeStr__ withString:@""]
#define REMOVEBR(__str__)   REMOVESRTTHE(__str__, @"<br>")
//#endif

//#define LocalString(__key__,__FileName__)  NSLocalizedStringFromTable(__key__, __FileName__, NULL)// NSLocalizedString(__key__, NULL)

#define StatusBarHeight 20


#import <objc/runtime.h>
#define extensions_property(varName,varType)\
- (varType) get##varName;\
- (void) set##varName:(varType)var;

#define extensions_synthesize(varName,varType)\
static  char Key##varName;\
- (varType) get##varName{\
    return objc_getAssociatedObject(self,&Key##varName);}\
- (void) set##varName:(varType)var{\
    objc_setAssociatedObject(self, &Key##varName, nil, OBJC_ASSOCIATION_ASSIGN);\
}
