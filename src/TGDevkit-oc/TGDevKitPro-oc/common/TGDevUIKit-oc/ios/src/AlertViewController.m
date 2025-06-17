//
//  ViewController.m
//  AlertView
//
//  Created by home on 2017/11/30.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "AlertViewController.h"
#import <objc/runtime.h>
#import "DatePicker.h"
#import "PickerView.h"
#import "NSObject+TGruntime.h"
#import "UIView+TG.h"

@interface AlertViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong) DatePicker *datePicker;
@property (nonatomic,strong) PickerView *pickerView;
@end

@implementation AlertViewController


- (DatePicker *) datePicker{
    if (!_datePicker) {
        
        _datePicker = [[DatePicker alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
    }
    return _datePicker;
}

- (PickerView *) pickerView{
    if (!_pickerView) {
        _pickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

//获得所有变量
- (NSArray *)getAllIvar:(id)object{
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    Ivar *ivars = class_copyIvarList([object class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const  char *keyChar = ivar_getName(ivar);
        NSString *keyStr = [NSString stringWithCString:keyChar encoding:NSUTF8StringEncoding];
        @try {
            id valueStr = [object valueForKey:keyStr];
            NSDictionary *dic = nil;
            if (valueStr) {
                dic = @{keyStr : valueStr};
            } else {
                dic = @{keyStr : @"值为nil"};
            }
            [array addObject:dic];
        }
        @catch (NSException *exception) {}
    }
    return [array copy];
}

- (void) pView:(UIView *)pview vv:(NSString *)str{
    for (UIView *view in [pview subviews]) {
        NSString *ps = [NSString stringWithFormat:@"%@%@",str,NSStringFromClass([view class])];
        printf("\n%s",[ps UTF8String]);
        
        if ([view isKindOfClass:[UIView class]]) {
            [self pView:view vv:[NSString stringWithFormat:@"%@%@%@",str,NSStringFromClass([view class]),str]];
        }
    }
}

- (BOOL) controller:(UIViewController *)controller showWithMsg:(NSString *)msg{
    NSArray *array = [msg componentsSeparatedByString:@"|"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"\n%@",array[0]] message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAtcion = [UIAlertAction actionWithTitle:(array.count > 1 ? array[1]:@"是") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAtcion];
    for (int i = 2; i < array.count; i++) {
        UIAlertAction *atcion = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:nil];
        [atcion setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alert addAction:atcion];
    }
    [controller presentViewController:alert animated:true completion:nil];
    return true;
}

- (IBAction) clickBAlert:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:nil cancelButtonTitle:@"a" otherButtonTitles:@"b", nil];
    NSArray *array = [self getAllIvar:alert];
    NSLog(@"array:%@",array);
    [self controller:self showWithMsg:@"阿法法师f|是|是否"];
}

- (IBAction) clickAlet:(id)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2017042014235011429.png"]];
    image.frame = CGRectMake(20, 20, 40, 40);
    NSArray *array = [self getAllIvar:alert];
    NSLog(@"array:%@",array);
    
//    //更改标题样式
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"周一至周五 上午12——下午12\n周六至周日 上午12——下午12"];
//    [title addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(3, 6)];
//    NSString *message = [alert setValue:@"周一至周五 上午12——下午12\n周六至周日 上午12——下午12\n" forKey:@"attributedMessage"];
    
    [alert setValue:message forKey:@"attributedMessage"];
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:@"标题" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [alert setValue:attributedTitle forKey:@"attributedTitle"];
//    [alert.view addSubview:image];
    UIAlertAction *cancelAtcion = [UIAlertAction actionWithTitle:@"asdasd" style:UIAlertActionStyleCancel handler:nil];
//    //文字颜色
//    UIColor *purple = [UIColor purpleColor];
//    [cancelAtcion setValue:purple forKey:@"titleTextColor"];

    [alert addAction:cancelAtcion];
//    NSLog(@"self.view:%@",NSStringFromCGRect(self.view.frame));
//    NSLog(@"alert.view:%@",NSStringFromCGRect(alert.view.frame));
//    [self presentViewController:alert animated:true completion:nil];
//    NSLog(@"alert.view:%@",NSStringFromCGRect(alert.view.frame));
    [self presentViewController:alert animated:true completion:nil];
//    NSLog(@"alert.textFields[0].frame:%@",NSStringFromCGRect(alert.textFields[0].frame));
    
    

}

- (IBAction) clickDatePick:(id)sender{
    [self.datePicker setHidden:!self.datePicker.hidden];
}

- (IBAction) clickPickerView:(id)sender{
    
//    [self pView:self.pickerView vv:@"└────"];
    [self.pickerView printAllSubView];
    [self.pickerView setHidden:!self.pickerView.hidden];
    id foregroundView = [self.pickerView valueForKey:@"foregroundView"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [foregroundView addGestureRecognizer:tap];
    [foregroundView setBackgroundColor:[UIColor redColor]];
    NSLog(@"[[UIPickerView alloc] init]:%@",[[[UIPickerView alloc] init] getAllIvar]);
    NSArray * tables = [self.pickerView valueForKey:@"tables"];
    
    id obj = [tables objectAtIndex:0];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUIPickerColumnView:)];
//    [obj addGestureRecognizer:tap];
    NSLog(@"[[obj class] superclass]:%@",[[obj class] superclass]);
    
//    [self pView:obj vv:@"--"];
    
//    NSLog(@"[obj subviews]:%@",[obj subviews]);
    
    NSArray *objarray = [obj getAllIvar];
    
//    NSLog(@"array:%@",objarray);
    
    NSLog(@"tables:%@",tables);
    id table = tables[0];
    UIView *vew;
    
    [table setUserInteractionEnabled:false];
    [table setMultipleTouchEnabled:false];
    NSLog(@"[tables[0] getAllIvar]:%@",[tables[0] getAllIvar]);
    id middleTable = [tables[0] valueForKey:@"middleTable"];
    NSLog(@"bottomTable:%@",[[middleTable class] superclass]);
    id topContainerView = [tables[0] valueForKey:@"middleTable"];
    id middleContainerView = [tables[0] valueForKey:@"middleContainerView"];
    [middleContainerView setBackgroundColor:[UIColor blueColor]];
    UITableView *tabl;
    id bottomTable = [tables[0] valueForKey:@"bottomTable"];
    id bottomContainerView = [tables[0] valueForKey:@"bottomContainerView"];
    [bottomContainerView setUserInteractionEnabled:false];
    [bottomTable setUserInteractionEnabled:false];
//    topTable
//    bottomTable
}

- (IBAction) clickEditAlert:(id)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"文本对话框" message:@"登录和密码对话框示例" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
    }];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:true completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.pickerView];
    return;
        // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"row:%ld,component%ld",row,component];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch began");
}
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch moved");
}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touches ended");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchUIPickerColumnView:(id)sender{
    NSLog(@"UIPickerColumnView");
}

- (void) tap:(id)sender{
    NSLog(@"[sender class]:%@",[sender class]);
}

@end
