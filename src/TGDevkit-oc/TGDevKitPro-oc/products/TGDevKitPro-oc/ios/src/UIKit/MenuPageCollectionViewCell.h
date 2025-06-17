//
//  MenuPageCollectionViewCell.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuPageCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) IBOutlet UIImageView *iconImage;
@property (nonatomic,weak) IBOutlet UILabel *txtTitle;

+ (NSString *) itemIdentifier;
- (void) reloadWithInfo:(NSDictionary *)info;
@end

NS_ASSUME_NONNULL_END
