//
//  MainTableViewController.m
//  iOS_DOME
//
//  Created by home on 2018/1/24.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "MainTableViewController.h"
#define KEY_TITLE   @"KEY_TITLE"
#define KEY_ITEMS    @"KEY_ITEMS"
#define KEY_VIEWCONTROLLERNAME  @"KEY_VIEWCONTROLLERNAME"
#import "ExampleUIWebViewController.h"
static NSString *cell_indentifier = @"cell_indentifier";
@interface MainTableViewController ()
@property (nonatomic,strong) NSArray *menuArray;
@end
#define ITEMBYVCNAME(__VCNAME)  @{\
KEY_TITLE:__VCNAME,\
KEY_VIEWCONTROLLERNAME:__VCNAME\
}
@implementation MainTableViewController
- (NSArray *) menuArray{
    ;
    if (_menuArray == nil){
        _menuArray = @[
                       @{
                           KEY_TITLE:@"WebViewJavascriptBridge",
                           KEY_ITEMS:@[
                                   ITEMBYVCNAME(@"ExampleUIWebViewController")
                                   , ITEMBYVCNAME(@"ExampleWKWebViewController")
                                   ]
                           }
                       ,@{
                           KEY_TITLE:@"MaskView",
                           KEY_ITEMS:@[
                                   ITEMBYVCNAME(@"MaskViewController")
                                   ]
                           }
                       ];
    }
    return _menuArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_indentifier"];
    [self.tableView reloadData];
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    return;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.menuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.menuArray[section];
    NSArray *items = dic[KEY_ITEMS];
    return items.count;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = self.menuArray[section];
    return dic[KEY_TITLE];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_indentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_indentifier];
    }
    NSDictionary *item = [self itemByIndexPath:indexPath];
    cell.textLabel.text = item[KEY_TITLE];
    return cell;
}

- (NSDictionary *) itemByIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.menuArray[indexPath.section];
    NSArray *items = dic[KEY_ITEMS];
    return items[indexPath.row];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = [self itemByIndexPath:indexPath];
    NSString *vcClassName =  item[KEY_VIEWCONTROLLERNAME];
    Class vcClass = NSClassFromString(vcClassName);
    id vc = nil;
    @try {
        id vc = [[vcClass alloc] init];
        if (!vc){
            @throw [[NSException alloc] initWithName:@"" reason:@"" userInfo:nil];
        }
        [self.navigationController pushViewController:vc animated:true];
    } @catch (NSException *exception) {
        NSLog(@"NSException :%@",exception);
    } @finally {

    }
    return;
}
/*
#pragma mark - Table view delegate


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
