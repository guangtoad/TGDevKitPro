//
//  MenuTableCellView.m
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/18.
//

#import "MenuTableCellView.h"
#import "TGImage.h"
#import "RegexToolViewController.h"

TG_CONST_VALUE_EXTERN MenuTableCellViewIdentifier = @"MenuTableCellViewIdentifier";

@implementation MenuTableCellView

+ (NSString *) viewIdentifier{
    return MenuTableCellViewIdentifier;
}

+ (NSNib *) viewNib{
    NSNib *cellViewNib = [[NSNib alloc] initWithNibNamed:@"MenuTableCellView" bundle:NULL];
    return cellViewNib;
}

+ (BOOL) registerToTableView:(NSTableView *)tableView{
    if (NULL == tableView || ![tableView isKindOfClass:[NSTableView class]]){
        return false;
    }
    [tableView registerNib:[self viewNib] forIdentifier:[self viewIdentifier]];
    return true;
}

- (void) reloadDataWithDict:(NSDictionary *)dict{
    
    self.txtTitle.stringValue = [dict objectForKey:TGKEY_TITLE];
    NSImage *image = [TGimage tg_imageWithString:[dict objectForKey:TGKEY_ICON]];
    self.imgIcon.image= image;
}

@end
