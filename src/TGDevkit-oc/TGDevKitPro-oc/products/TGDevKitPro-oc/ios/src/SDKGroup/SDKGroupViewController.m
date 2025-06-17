//
//  SDKGroupViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/1.
//

#import "SDKGroupViewController.h"

@interface SDKGroupViewController ()

@end

@implementation SDKGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (NULL != cell) {
        [self tg_oepnRUI:cell.tg_RoulerURL];
        [cell setSelected:false];
    }
}

@end
