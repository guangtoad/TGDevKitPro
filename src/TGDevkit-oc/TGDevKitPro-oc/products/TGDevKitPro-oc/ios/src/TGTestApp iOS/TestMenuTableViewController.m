//
//  TestMenuTableViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/29.
//

#import "TestMenuTableViewController.h"
#import "NetStateViewController.h"
#import "SRIDCardViewController.h"
@interface TestMenuTableViewController ()

@end

@implementation TestMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)oepnRUI:(NSString *)uri{
    if (NULL == uri) {
        return false;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithString:uri];
    if (NULL == components) {
        return false;
    }
    if ([@"push" isEqualToString:[components.scheme lowercaseString]]) {
        NSString *nib = components.host;
        BOOL hidesBottom = true;
        NSString *storyboardc = NULL;
        
        for (NSURLQueryItem *queryItem in components.queryItems) {
            if ([@"nib" isEqualToString:[queryItem.name lowercaseString]]) {
                nib = queryItem.value;
            }
            else if ([@"storyboardc" isEqualToString:[queryItem.name lowercaseString]]) {
                
            }
            else if ([@"hidesBottom" isEqualToString:[queryItem.name lowercaseString]]){
                if ([queryItem.name respondsToSelector:@selector(boolValue)]) {
                    hidesBottom = [queryItem.name boolValue];
                }
            }
        }
        
        Class class = NSClassFromString(components.host);
        if (NULL == class) {
            return false;
        }
        if (![class isSubclassOfClass:[UIViewController class]]) {
            return false;
        }
        UIViewController *controller = NULL;
        if (NULL != [[NSBundle mainBundle] pathForResource:nib ofType:@"nib"]) {
            controller = [[class alloc] initWithNibName:nib bundle:NULL];
        }
        else {
            controller = [[class alloc] init];
        }
        if (NULL != controller) {
            controller.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:controller animated:true];
            return true;
        }
        
    }
    return false;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (NULL == cell) {
        return;
    }
    if ([self oepnRUI:cell.appurl]) {
        return;
    }
    [cell setSelected:false];
    UIViewController *viewController = NULL;
    if (NULL == cell.reuseIdentifier) {
        return;
    }
    else if ([@"NetStateViewController" isEqualToString:cell.reuseIdentifier]) {
        viewController = [[NetStateViewController alloc] initWithNibName:@"NetStateViewController" bundle:NULL];
    }
    else if ([@"SRIDCardViewController" isEqualToString:cell.reuseIdentifier]) {
//        viewController = [[SRIDCardViewController alloc] initWithNibName:@"SRIDCardViewController" bundle:NULL];
    }
    if (NULL != viewController) {
        [self.navigationController pushViewController:viewController animated:true];
        viewController.hidesBottomBarWhenPushed = true;
    }
}

@end
