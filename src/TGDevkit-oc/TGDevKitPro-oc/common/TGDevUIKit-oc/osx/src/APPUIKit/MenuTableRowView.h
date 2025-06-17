//
//  MenuNSTableRowView.h
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableRowView : NSTableRowView

- (void) reloadDataWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
