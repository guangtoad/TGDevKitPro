//
//  EditInfoCell.h
//  TGCodeRows
//
//  Created by toad on 2022/08/04.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditInfoCell : NSTableCellView

@property (weak) IBOutlet NSTextField *infoTxt;
@property (weak) IBOutlet NSTextField *titleTxt;

@end

NS_ASSUME_NONNULL_END
