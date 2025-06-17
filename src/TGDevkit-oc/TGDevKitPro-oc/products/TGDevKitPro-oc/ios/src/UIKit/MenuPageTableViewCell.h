//
//  MenPageItemTableViewCell.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuPageTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *iconImage;
@property (nonatomic,weak) IBOutlet UILabel *txtTitle;
@property (nonatomic,weak) IBOutlet UILabel *txtDescription;

+ (NSString *) itemIdentifier;
- (void) reloadWithInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
