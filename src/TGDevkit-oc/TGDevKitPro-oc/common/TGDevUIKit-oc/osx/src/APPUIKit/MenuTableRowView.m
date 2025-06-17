//
//  MenuNSTableRowView.m
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import "MenuTableRowView.h"

@implementation MenuTableRowView

- (void)viewDidMoveToWindow{
    NSLog(@"self.accessibilityVisibleCells:%@",self.accessibilityVisibleCells);
}

- (void) reloadDataWithDictionary:(NSDictionary *)dictionary{
    self.accessibilityTitle = @"111";
    NSLog(@"self.accessibilityVisibleCells:%@",self.accessibilityVisibleCells);
}
@end
