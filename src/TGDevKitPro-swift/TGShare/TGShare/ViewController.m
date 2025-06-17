//
//  ViewController.m
//  TGShare
//
//  Created by home on 2018/4/14.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "ViewController.h"
#import <Toast/Toast.h>
#import "TGPopView.h"
#import "TGSheetView.h"
#import "TGShareView.h"
#import "TGDatePickerView.h"
#import "TGDorpMenu.h"
@interface ViewController ()
@property (nonatomic,assign) TGDatePickerMode mode;
@end

@implementation ViewController

- (IBAction) rightItemClick:(id)sender{
//    TGDorpMenuStyle *style = [[TGDorpMenuStyle alloc] init];
    TGDorpMenu *menu = [[TGDorpMenu alloc] initWithSender:sender dataArray:@[menuItem(@"", @"title"),menuItem(@"", @"title"),menuItem(@"", @"title")] block:^(NSInteger index) {
        NSLog(@"touch index:%ld",index);
    }];
    [menu show];
//    [menu setBackgroundColor:[UIColor greenColor]];
//    [menu showWithView:sender];
}
- (IBAction)bbbb:(id)sender {

    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageColor = [UIColor orangeColor];
    style.backgroundColor = [UIColor greenColor];
    style.titleColor = [UIColor whiteColor];
    style.messageColor = [UIColor whiteColor];
    //    style.horizontalPadding = 60.0;
//    style.verticalPadding = 60;
//    style.cornerRadius = 30;
//    style.activitySize = CGSizeMake(100, 800);
    [self.view makeToast:@"设置默认地址成功" duration:0.3 position:nil style:style];
}
- (IBAction)SHARE:(id)sender {
    [[[TGShareView alloc] init] show];
}
- (IBAction)shopopview:(id)sender {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
    [view setBackgroundColor:[UIColor redColor]];
    TGPopView.createObj().showPopview(view);
    
}
- (IBAction)datepick:(id)sender {
    self.mode = self.mode > TGDatePickerModeHourMinute ? TGDatePickerModeYearMonthDayHourMinute : self.mode;

    [TGDatePickerView.createmode(TGDatePickerModeYearMonthDay)
     .titleSet(@"asdasd")
     .maxDateSet([NSDate date])
     .blockSet(^(NSDate *date){

    }).errorBlockSet(^BOOL(TGDatePickerViewSelectCode code){
        return false;
    }) show];
//    TGDatePickerView *dataPicker = [[TGDatePickerView alloc] initWithMode:self.mode++ title:@"asdasd"];

//    TGDatePickerView *dataPicker = [[TGDatePickerView alloc] initWithMode:TGDatePickerModeYearMonthDay title:@"asdasd"];
//    [dataPicker show];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    // toggle "tap to dismiss" functionality
    [CSToastManager setTapToDismissEnabled:YES];

    // toggle queueing behavior
    [CSToastManager setQueueEnabled:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)touchsheet:(id)sender {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
//    TGSheetView *sheetView = [[TGSheetView alloc] initWithStyle:nil Title:@"" cancelButtonTitle:@"asdasd" contextView:view];
    TGSheetView *sheetView = [[TGSheetView alloc] initWithStyle:nil Title:@"" cancelButtonTitle:@"SAFASF" otherButtonTitles:@[@"ASD",@"ASD"] actionSheetBlock:^(NSInteger index) {
        NSLog(@"touch index:%ld",(long)index);
    } ];
    [sheetView show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
