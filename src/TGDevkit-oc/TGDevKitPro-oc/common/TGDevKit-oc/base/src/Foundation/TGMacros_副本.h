//
//  TGMacros.h
//  JGZ
//
//  Created by toad on 13-4-1.
//  Copyright (c) 2013年 toad. All rights reserved.
//

#import "TGMath.h"

#ifndef JGZ_TMacros_h
#define JGZ_TMacros_h

//#define TGLOGINFO(xx, ...) {\
//NSString *TGFUNCTION_funStr = [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];]\
//[TGFUNCTION_funStr stringByReplacingOccurrencesOfString:@"-[" withString:@""];\
//[TGFUNCTION_funStr stringByReplacingOccurrencesOfString:@"]" withString:@""];\
//NSArray *TGFUNCTION_Array = [TGFUNCTION_funStr componentsSeparatedByString:@" "];\
//NSString *TGFUNCTION_pStr = [NSString stringWithFormat:@"%@[len%d]%@",TGFUNCTION_Array[0],__LINE__,TGFUNCTION_Array[1]];\
//NSLog(@"\n%@",TGFUNCTION_pStr xx,TGFUNCTION_pStr, ##__VA_ARGS__);\
//}

#define TGLOGINFO(xx, ...) NSLog(@"%s[len:%d]\n" xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#if !defined(DEBUG)
#define DEBUG 0
#endif
#if DEBUG == 0
#define TGLOGFUN() do {} while (0)
#define TGLOG(...) do {} while (0)
#define TGLOGINFO(...) do {} while (0)
#define TGLOGERROR(...) do {} while (0)
#define TGAssert(condition, desc, ...) do {} while (0)
#define TGLOGException(__e)
#define TGLOGERROR(...) do {} while (0)

#elif DEBUG == 1

#define TGLOGFUN() NSLog(@"len:%d,%s" ,__LINE__,__PRETTY_FUNCTION__)
#define TGLOG(...) NSLog(__VA_ARGS__)
#define TGLOGERROR(...) NSLog(__VA_ARGS__)
#define TGAssert(condition, desc, ...) NSAssert(condition, desc, ...)
#define TGLOGException(__e) NSLog(@"Exception:%@" ,__e)
#elif DEBUG > 1

#define TGLOGFUN() NSLog(@"len:%d,%s" ,__LINE__,__PRETTY_FUNCTION__)
#define TGLOG(...) NSLog(__VA_ARGS__)
#define TGLOGERROR(...) NSLog(__VA_ARGS__)
#define TGAssert(condition, desc, ...) NSAssert(condition, desc, ...)
#define TGLOGException(__e) NSLog(@"Exception:%@" ,__e)
#endif

//-fno-objc-arc
#if ! __has_feature(objc_arc)
#define TGAutorelease(__v)      ([__v autorelease])
#define TGRetain(__v)           ([__v retain])
#define TGRelease(__v)           ([__v release])

#define TGRetainCount(__v)      ([__v retainCount])
#define TGDealloc()               ([super dealloc])
#define TGCopy(__v)             ([__v copy])
#else
// -fobjc-arc

#define TGAutorelease(__v)      (__v)
#define TGRetain(__v)           (__v)
#define TGRelease(__v)           (__v)

#define TGRetainCount(__v)      (__v)
#define TGDealloc()             {}(0)
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

#if __has_include(<objc/runtime.h>)
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
#endif

#define NSNotificationCenterRemoveSelf()  [[NSNotificationCenter defaultCenter] removeObserver:self]
