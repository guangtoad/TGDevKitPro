//
//  TestDevMenuTableViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/24.
//

#import "TestDevMenuTableViewController.h"

@interface TestDevMenuTableViewController ()

@property (nonatomic,strong) NSMutableArray *dataSoure;

@end

@implementation TestDevMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self tg_oepnRUI:cell.tg_url];
    [cell setSelected:false];
    
}

@end
