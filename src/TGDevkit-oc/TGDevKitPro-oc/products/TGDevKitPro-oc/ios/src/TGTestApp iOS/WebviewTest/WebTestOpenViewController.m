//
//  WebTestOpenViewController.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/21.
//

#import "WebTestOpenViewController.h"
#import "TestWebViewController.h"
@interface WebTestOpenViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet BaseTextField *txt_uri;
@property (nonatomic,strong) IBOutlet UITableView *historyTableView;
@property (nonatomic,strong) NSMutableArray *historyDataArray;

@end

@implementation WebTestOpenViewController

- (NSMutableArray *)historyDataArray{
    if (!_historyDataArray) {
        _historyDataArray = [[NSMutableArray alloc] init];
        NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
        id objc = [userDefults objectForKey:@"WEBVIEWHISTORY"];
        if (objc != NULL && [objc isKindOfClass:[NSArray class]]) {
            [_historyDataArray addObjectsFromArray:objc];
        }
    }
    return _historyDataArray;
}
- (void) saveTextURI:(NSString *)str{
    if (NULL != str) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:str forKey:@"TESTURI"];
        NSInteger index = [self.historyDataArray indexOfObject:str];
        if (NSNotFound != index) {
            [self.historyDataArray removeObjectAtIndex:index];
            [self.historyDataArray insertObject:str atIndex:0];
        }
        NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
        [userDefults setObject:self.historyDataArray forKey:@"WEBVIEWHISTORY"];
        [userDefults synchronize];
        [userDefault synchronize];
    }
}

- (IBAction) click_openWebview:(id)sender{
    [self saveTextURI:self.txt_uri.text];
//    TestWebViewController *controller = [[TestWebViewController alloc] init];
//    controller.uri = self.txt_uri.text;
//    controller.hidesBottomBarWhenPushed = true;
//    [self.navigationController pushViewController:controller animated:true];
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.txt_uri.text = [userDefault stringForKey:@"TESTURI"];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.historyTableView]) {
        return 1;
    }
    else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.historyDataArray.count;
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebTestOpenViewControllerCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WebTestOpenViewControllerCell"];
    }
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case 0:
            cell.textLabel.text = row < self.historyDataArray.count ? self.historyDataArray[row] : @"";
            break;
        default:
            break;
    }
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
