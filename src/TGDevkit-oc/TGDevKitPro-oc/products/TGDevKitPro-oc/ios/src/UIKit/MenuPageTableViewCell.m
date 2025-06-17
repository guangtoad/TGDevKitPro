//
//  MenPageItemTableViewCell.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/1.
//

#import "MenuPageTableViewCell.h"
#import <TGFoundation/TGFoundation.h>

@implementation MenuPageTableViewCell

+ (NSString *) itemIdentifier{
    return @"MenuPageTableViewCell";
}
- (void) reloadWithInfo:(NSDictionary *)info{
    if (NULL == info) {
        [self setTg_RoulerURL:@""];
        self.txtTitle.text = @"-";
        self.txtDescription.text = @"-";
        self.tg_RoulerURL = @"";
    }
    else {
        self.txtTitle.text = [NSString stringWithFormat:@"%@",stringValueByObjDef(info[TGKEY_TITLE], @"-")];
        self.txtDescription.text = [NSString stringWithFormat:@"%@",stringValueByObjDef(info[TGKEY_DESCRIPTION], @"-")];
        self.tg_RoulerURL = info[TGKEY_URL];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
