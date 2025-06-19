//
//  TGPickerView.m
//  ObjCDome
//
//  Created by toad on 2017/11/27.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "TGPickerView.h"

#define COM_YEAR    0
#define COM_MONTH   1
#define COM_DAY     2
#define COM_HOUR    3
#define COM_TIME    3

@interface TGPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign) NSInteger TimeRange;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * confirmButton;

@property (nonatomic, assign) NSInteger yearNumber;

@end

@implementation TGPickerView

- (void) setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour{
    
    if (month == 12 && day > 2) {
        self.yearNumber = 2;
    }
    return;
}

- (void) setSelectTimeIntervalSince1970:(NSTimeInterval)timeInterval{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components:unitFlags
                                          fromDate:date];
    [self setYear:comp.year month:comp.month day:comp.day hour:comp.hour];
    [gregorian release];
    return;
}
- (void) setSelectTimeIntervalNow{
    [self setSelectTimeIntervalSince1970:[NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
}

- (id) initWithView:(UIView *)view{
    CGRect frame = CGRectMake(0, CGRectGetMaxY(view.frame), CGRectGetWidth(view.frame), 258);
    if (self = [self initWithFrame:frame]){
        [view addSubview:self];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        self.yearNumber = 1;
        self.TimeRange = 30 * 24 * 60;
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-1, 0,[UIScreen mainScreen].bounds.size.width + 2, 44)];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.layer.borderColor = [UIColor colorWithRed:220/255. green:220/255. blue:220/255. alpha:1].CGColor;
        self.titleLabel.layer.borderWidth = 1.0;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        [self addSubview:self.titleLabel];
        CGSize size = [@"确定" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 17)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}
                                          context:nil].size;
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-15-size.width,0 , size.width, 44)];
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.confirmButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.confirmButton];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(frame)-CGRectGetMaxY(self.titleLabel.frame))];
        //改变pickerview的高度
        self.pickerView.layer.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(frame)-CGRectGetMaxY(self.titleLabel.frame));
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.showsSelectionIndicator = YES;
        [self addSubview:self.pickerView];
        [self.pickerView reloadAllComponents];
    }
    return self;
}

- (void) show{
    [self setHidden:false];
    [self setUserInteractionEnabled:false];
    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, - self.frame.size.height);
    } completion:^(BOOL com){
        [self setUserInteractionEnabled:true];
    }];
}
- (void) dissm{
    [self setUserInteractionEnabled:false];
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0,  self.frame.size.height);
    } completion:^(BOOL com){
        [self setHidden:true];
        [self setUserInteractionEnabled:false];
    }];
}

- (void) buttonClick:(id)sender{
    [self dissm];
}

#pragma mark -- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case COM_YEAR:{
            return @"2017";
            break;
        }
        case COM_MONTH:{
            break;
        }
        case COM_DAY:{
            break;
        }
        case COM_HOUR:{
            break;
        }
        default:{
            break;
        }
    }
    return @"sdfsdf";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    return;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view  {
    [self changeSpearatorLineColor];
    CGFloat width = 0;
    
//    CGSize yearSize = [[self yearForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
//    UILabel *label = [[UILabel alloc] initWithFrame:cgre]
    
//    myView.textAlignment = NSTextAlignmentCenter;
//    myView.backgroundColor = [UIColor blackColor];
    switch (component) {
        case COM_YEAR:{
            break;
        }
        case COM_MONTH:{
            break;
        }
        case COM_DAY:{
            break;
        }
        case COM_HOUR:{
            break;
        }
        default:{
            break;
        }
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)changeSpearatorLineColor{
    for(UIView *speartorView in self.pickerView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = [UIColor colorWithRed:220/255. green:220/255. blue:220/255. alpha:1.];//隐藏分割线
        }
    }
}

#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case COM_YEAR:{
            return self.yearNumber;
        }
        case COM_MONTH:{
            break;
        }
        case COM_DAY:{
            break;
        }
        case COM_HOUR:{
            break;
        }
        default:{
            break;
        }
    }
    return 6;
}
@end
