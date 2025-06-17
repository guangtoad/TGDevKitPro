//
//  TGimage.h
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGimage : NSImage

+ (NSImage *) tg_imageWithString:(NSString *)aString;

@end

NS_ASSUME_NONNULL_END
