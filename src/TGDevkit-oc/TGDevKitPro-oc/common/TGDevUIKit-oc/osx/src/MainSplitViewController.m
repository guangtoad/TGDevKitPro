//
//  MainSplitViewController.m
//  TG Develop Tools macos
//
//  Created by toad on 2022/11/17.
//

#import "MainSplitViewController.h"
#import "RegexToolViewController.h"
@interface MainSplitViewController ()

@property (nonatomic,assign) NSInteger selectMenuIndex;

@end

@implementation MainSplitViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    if ([self.leftViewItem.viewController isKindOfClass:[MenuTableViewController class]]){
        [(MenuTableViewController *)self.leftViewItem.viewController setMenuDelegate:self];
    }
    NSLog(@"self.splitViewItems:%@",self.splitViewItems);
}

#pragma mark - MenuTableViewDelegate
- (BOOL)menuTableViewController:(MenuTableViewController *)controller didSelectRow:(NSInteger)row info:(NSDictionary *)info{
    if (self.selectMenuIndex != row) {
        RegexToolViewController *viewController = [[RegexToolViewController alloc] initWithNibName:@"RegexToolViewController" bundle:NULL];
        NSSplitViewItem *splitViewItem = [NSSplitViewItem splitViewItemWithViewController:viewController];
        [self removeSplitViewItem:self.rightViewItem];
        [self addSplitViewItem:splitViewItem];
        self.rightViewItem = splitViewItem;
        [info objectForKey:TGKEY_URL];
    }
    self.selectMenuIndex = row;
    return true;
}

@end
