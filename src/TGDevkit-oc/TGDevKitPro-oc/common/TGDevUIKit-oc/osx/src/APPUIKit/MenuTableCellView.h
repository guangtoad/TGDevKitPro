//
//  MenuTableCellView.h
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/18.
//

#import <Cocoa/Cocoa.h>

TG_CONST_KEY_EXTERN MenuTableCellViewIdentifier;

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableCellView : NSView

@property (weak) IBOutlet NSImageView *imgIcon;
@property (weak) IBOutlet NSTextField *txtTitle;
@property (weak) IBOutlet NSTextField *txtSubTitle;

+ (NSString *) viewIdentifier;
+ (NSNib *) viewNib;
+ (BOOL) registerToTableView:(NSTableView *)tableView;
- (void) reloadDataWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
