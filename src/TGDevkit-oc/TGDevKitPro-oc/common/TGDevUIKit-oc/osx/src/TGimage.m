//
//  TGimage.m
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import "TGimage.h"
typedef NSString *TGKEY NS_TYPED_EXTENSIBLE_ENUM;

#if TARGET_OS_OSX
#define TGKIT_EXTERN APPKIT_EXTERN

#elif TARGET_OS_WATCH
    #import <WatchKit/WatchKit.h>
#elif TARGET_OS_OSX
    #import <AppKit/AppKit.h>
#endif

@implementation TGimage

+ (NSImage *) tg_imageWithString:(NSString *)aString{    
    if (NULL == aString) {
        return NULL;
    }
    else if ([aString isKindOfClass:[NSString class]]){
        if ([aString hasPrefix:PRE_KEY_PATH]) {
            [aString substringToIndex:PRE_KEY_PATH.length];
        }
        else if ([aString hasPrefix:PRE_KEY_HEX]) {
            [aString substringToIndex:PRE_KEY_HEX.length];
        }
        else if ([aString hasPrefix:PRE_KEY_BASE64]) {
            [aString substringToIndex:PRE_KEY_BASE64.length];
        }
        else {
            if ([aString pathExtension].length > 0){
                NSString *path = [[NSBundle mainBundle] pathForResource:[aString stringByDeletingPathExtension] ofType:[aString pathExtension]];
                return [[NSImage alloc] initWithContentsOfFile:path];
            }
            else {
                return [NSImage imageNamed:aString];
            }
        }
    }
    return NULL;
}
- (id) inisdf:(NSString *)aiamg{
    
    if (NULL == aiamg) {
        
    }
    else if ([aiamg isKindOfClass:[NSString class]]){
        if ([aiamg hasPrefix:PRE_KEY_PATH]) {
            [aiamg substringToIndex:PRE_KEY_PATH.length];
        }
        else if ([aiamg hasPrefix:PRE_KEY_HEX]) {
            [aiamg substringToIndex:PRE_KEY_HEX.length];
        }
        else if ([aiamg hasPrefix:PRE_KEY_BASE64]) {
            [aiamg substringToIndex:PRE_KEY_BASE64.length];
        }
        else {
            [NSImage imageNamed:aiamg];
        }
    }
    return NULL;
    
//    UIImage *image = [UIImage imageWithData:];
//    [[NSImage alloc] initWithContentsOfFile:<#(nonnull NSString *)#>]
    
}

@end
