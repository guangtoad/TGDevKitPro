//
//  MenuItemCellTableViewCell.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/15.
//

#import "MenuItemTableViewCell.h"

@implementation MenuItemTableViewCell

+ (instancetype) nibView{
    id cell = [TGBundleUtil loadNibNamed:NSStringFromClass([self class]) owner:self];
    return cell;
}

+ (NSArray<NSString *> *) nibNames{
    return @[NSStringFromClass([self class])];
}

+ (NSString *) reuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (void) registerNib:(UITableView *)talbeView{
    for (NSString *name in [self nibNames]) {
        UINib *nib = [UINib nibWithNibName:name bundle:NULL];
        [talbeView registerNib:nib forCellReuseIdentifier:[self reuseIdentifier]];
    }
}

- (void) awakeFromNib{
    [super awakeFromNib];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
