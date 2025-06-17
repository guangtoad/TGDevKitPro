//
//  MenuItemCellTableViewCell.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/15.
//

#import <UIKit/UIKit.h>
#import "TGDevelopToolsUIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuItemTableViewCell : UITableViewCell

+ (void) registerNib:(UITableView *)talbeView;
+ (NSArray<NSString *> *) nibNames;
+ (NSString *) reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
