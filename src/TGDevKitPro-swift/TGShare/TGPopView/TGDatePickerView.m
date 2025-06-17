//
//  TGDatePickerView.m
//  smartGLink_cn
//
//  Created by home on 2018/3/15.
//  Copyright © 2018年 TechnoASKA. All rights reserved.
//

#import "TGDatePickerView.h"

#define COM_YEAR    1
#define COM_MONTH   3
#define COM_DAY     5
#define COM_TIME    7
//#define PIKERVIEWSYSPACING 4
const CGFloat PIKERVIEWSYSPACING = 5;
const CGFloat TitleWidth = 32;

@implementation TGDatePickerViewStyle

- (id) init{
    if (self = [super init]) {
        //reset TGPopViewStyle
        self.backgroundColor = [UIColor clearColor];
        //set style
        _headerHgiht = 44.0;
        _viewBackGroundColor = [UIColor whiteColor];
        _titleFont = [UIFont systemFontOfSize:16];
        _titleColor = [UIColor blackColor];
//        _headerBackgroundColor = [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
        _confirmButtonFont = [UIFont systemFontOfSize:14];
        _confirmButtonTxt = @"确定";

        _pickerHeight = 258.0;
        _pickerFont = [UIFont systemFontOfSize:12];
        _pickerRowHeight = 35.0;
        _pickerLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    }
    return self;
}

@end
/**
 数据选择器
 */
@interface TGDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/** 日期选择器 */
@property (nonatomic, strong) UIDatePicker *datePicker;
/** 数据选择器 */
@property (nonatomic, strong) UIPickerView *dataPicker;
/** 数据格式 */
@property (nonatomic, assign) TGDatePickerMode mode;
/** 日期格式 */
@property (nonatomic, assign) NSString *dateFormat;
/** 标题 */
@property (nonatomic, strong) UILabel * titleLabel;
/** 确定按钮 */
@property (nonatomic, strong) UIButton * confirmButton;
/** 选择器view */
@property (nonatomic, strong) UIView *pickerView;
/** 遮罩view */
@property (nonatomic, strong) UIView *maskView;
/** block */
@property (nonatomic, strong) TGDatePickerViewBlock block;
@property (nonatomic,strong) TGDatePickerViewErrorBlock errorBlock;
@property (nonatomic,strong) NSDate *maxDate;
@property (nonatomic,strong) NSDate *minDate;
@property (nonatomic,strong) NSDate *date;
@end

@implementation TGDatePickerView
#pragma mark - function

- (TGDateItem) dateItemWithDate:(NSDate *)date{

    TGDateItem item;

    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = nil;
    if (date != nil) {
        components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    }
    else {
        components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:[NSDate date]];

    }

    item.year = [components year];
    item.mothon = [components month];
    item.day = [components day];
    item.hour = [components hour];
    item.minute = [components minute];
    item.second = [components second];
    item.weekday = [components weekday];
    return item;
}
- (NSInteger) numberByMode{
    NSInteger number = 1;
    switch (self.mode) {
        case TGDatePickerModeTime:
            break;
        case TGDatePickerModeDate:
            break;
        case TGDatePickerModeDateAndTime:
            break;
        case TGDatePickerModeCountDownTimer:
            break;
        case TGDatePickerModeYearMonthDayHourMinute:{
            number = 5;
            break;
        }
        case TGDatePickerModeMonthDayHourMinute:{
            number = 4;
            break;
        }
        case TGDatePickerModeYearMonthDay:{
            number = 3;
            break;
        }
        case TGDatePickerModeYearMonth:{
            number = 2;
            break;
        }
        case TGDatePickerModeMonthDay:{
            number = 2;
            break;
        }
        case TGDatePickerModeHourMinute:{
            number = 2;
            break;
        }
    }
    return number * 2;
}

- (TGDateItem) nowDateItem{
    NSDate *currentDate = [NSDate date];
    return [self dateItemWithDate:currentDate];
}

- (NSInteger) rowWithYear:(NSInteger)year{
    return MAX(0, year - 1900);
}
- (NSInteger) yearWithRow:(NSInteger)row{
    return row + 1900;
}

- (NSString *) yearStrWithRow:(NSInteger)row{
    return [NSString stringWithFormat:@"%ld",[self yearWithRow:row]];
}

- (NSInteger) mothonWithRow:(NSInteger)row year:(NSInteger)year{
    return row + 1;
}

- (NSInteger) dayWithRow:(NSInteger)row year:(NSInteger)year month:(NSInteger)month{
    return row + 1;
}
- (NSInteger) hourWithRow:(NSInteger)row year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    return row + 1;
}
- (NSInteger) minuteWithRow:(NSInteger)row year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour{
    return row + 1;
}
- (NSInteger) dayWithRow:(NSInteger)row year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute{
    return row + 1;
}
- (NSString *) pickerTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //    TGDateItem item = [self nowDateItem];
    switch (self.mode) {
        case TGDatePickerModeTime:
        case TGDatePickerModeDate:
        case TGDatePickerModeDateAndTime:
        case TGDatePickerModeCountDownTimer:
        case TGDatePickerModeYearMonthDayHourMinute:{
            switch (component) {
                case 0:
                    return [self yearStrWithRow:row];
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeMonthDayHourMinute:{

            break;
        }
        case TGDatePickerModeYearMonthDay:{
            switch (component) {
                case 0:
                    return [self yearStrWithRow:row];
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeYearMonth:{
            switch (component) {
                case 0:
                    return [self yearStrWithRow:row];
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeMonthDay:
            break;
        case TGDatePickerModeHourMinute:
            break;
    }
    return [NSString stringWithFormat:@"%02ld",row + 1];
}
- (void) reloadDate{
    if (self.date != nil) {

    }
}

- (UIView *) pickerViewWithMode:(TGDatePickerMode)mode{
    CGRect pickerframe = CGRectMake(0, 0, CGRectGetWidth(self.frame) , [(TGDatePickerViewStyle *)self.style pickerHeight]);
    TGDateItem dateItem = [self dateItemWithDate:self.date];
    UIView *view = nil;
    switch (mode) {
        case TGDatePickerModeTime:
        case TGDatePickerModeDate:
        case TGDatePickerModeDateAndTime:
        case TGDatePickerModeCountDownTimer:
            view = _datePicker;
            _datePicker = [[UIDatePicker alloc] initWithFrame:pickerframe];
            _datePicker.backgroundColor = self.style.backgroundColor;

            break;
        default:
            _dataPicker = [[UIPickerView alloc] initWithFrame:pickerframe];
            _dataPicker.backgroundColor = self.style.backgroundColor;
            _dataPicker.delegate = self;
            _dataPicker.dataSource = self;
            view = _dataPicker;
            NSInteger number = [self numberByMode];
            switch (self.mode) {
                case TGDatePickerModeYearMonthDayHourMinute:
                    [self addLabelWithName:@[@"年",@"月",@"日",@"时",@"分"] number:number];
                    [_dataPicker selectRow:dateItem.year inComponent:0 * 2 animated:false];
                    [_dataPicker selectRow:dateItem.mothon inComponent:1 * 2 animated:false];
                    [_dataPicker selectRow:dateItem.day inComponent:2 * 2 animated:false];
                    [_dataPicker selectRow:dateItem.hour inComponent:3 * 2 animated:false];
                    [_dataPicker selectRow:dateItem.minute inComponent:3 * 2 animated:false];
                    //            [self addLabelWithName:@[@"年",@"月",@"日",@"时",@"分"]];
                    break;
                case TGDatePickerModeMonthDayHourMinute:
                    [self addLabelWithName:@[@"月",@"日",@"时",@"分"] number:number];
                    //            [self addLabelWithName:@[@"月",@"日",@"时",@"分"]];
                    break;
                case TGDatePickerModeYearMonthDay:
                    [self addLabelWithName:@[@"年",@"月",@"日"] number:number];

                    [_dataPicker selectRow:[self rowWithYear:dateItem.year] inComponent:0 * 2 animated:false];
                    [_dataPicker selectRow:dateItem.mothon - 1 inComponent:1 * 2 animated:false];
                    [_dataPicker selectRow:dateItem.day - 1 inComponent:2 * 2 animated:false];
                    break;
                case TGDatePickerModeYearMonth:
                    [self addLabelWithName:@[@"年",@"月"] number:number];
                    //            [self addLabelWithName:@[@"年",@"月"]];
                    break;
                case TGDatePickerModeMonthDay:
                    [self addLabelWithName:@[@"月",@"日"] number:number];
                    break;
                case TGDatePickerModeHourMinute:
                    [self addLabelWithName:@[@"时",@"分"] number:number];
                    break;
                case TGDatePickerModeTime:
                case TGDatePickerModeDate:
                case TGDatePickerModeDateAndTime:
                case TGDatePickerModeCountDownTimer:
                default:
                    break;
            }
            [_dataPicker reloadAllComponents];
            break;
    }
    return view;
}
- (NSInteger) labelFontSize{
    return 20;
}
- (NSString *) yearForm{
    return @"0000年";
}
- (NSString *) monthForm{
    return @"00月";
}
- (NSString *) yearForom{
    return @"0000";
}
- (NSString *) dayForm{
    return @"00日";
}
- (NSString *) timeForm{
    return @"00:00";
}
#pragma mark - 属性设置
- (void) setDate:(NSDate *)date{
    _date = date;

}
#pragma mark - 初始化
- (UIView *) popHeadView:(NSString *)title{

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), [(TGDatePickerViewStyle *)self.style headerHgiht])];
    header.backgroundColor = [(TGDatePickerViewStyle *)self.style headerBackgroundColor];

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(header.frame) , [(TGDatePickerViewStyle *)self.style headerHgiht])];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [(TGDatePickerViewStyle *)self.style titleColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.text = title;
    [header addSubview:_titleLabel];
    
    CGSize size = [[(TGDatePickerViewStyle *)self.style confirmButtonTxt] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 17)
                                                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                                                    attributes:@{NSFontAttributeName: [(TGDatePickerViewStyle *)self.style confirmButtonFont]}
                                                                                       context:nil].size;
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(header.frame) - 15 - size.width,0 , size.width, [(TGDatePickerViewStyle *)self.style headerHgiht])];
    [_confirmButton setTitle:[(TGDatePickerViewStyle *)self.style confirmButtonTxt] forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [(TGDatePickerViewStyle *)self.style confirmButtonFont];
    [_confirmButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:_confirmButton];
    return header;
}

/**
 Description

 @param mode mode description
 @param title title description
 @return return value description
 */
- (UIView *) popViewWithMode:(TGDatePickerMode)mode title:(NSString *)title{
    UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0)];
    UIView *header = [self popHeadView:title];
    popView.backgroundColor = [(TGDatePickerViewStyle *)self.style viewBackGroundColor];
    [popView addSubview:header];
    UIView *picker = [self pickerViewWithMode:self.mode];
    CGRect frame = picker.frame;
    frame.origin.y = CGRectGetHeight(header.frame);
    picker.frame = frame;
    [popView addSubview:picker];
    frame = popView.frame;
    frame.size.height = CGRectGetMaxY(picker.frame);
    popView.frame = frame;
    return popView;
}

/**
 日期pick

 @return UIDatePicker
 */
- (UIDatePicker *) datePicker{
    if (!_datePicker) {
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), [(TGDatePickerViewStyle *)self.style pickerHeight]);
        _datePicker = [[UIDatePicker alloc] initWithFrame:frame];
        [_datePicker setLocale:[(TGDatePickerViewStyle *)self.style pickerLocale]];
        switch (self.mode) {
            case TGDatePickerModeTime:
            case TGDatePickerModeDate:
            case TGDatePickerModeDateAndTime:
            case TGDatePickerModeCountDownTimer:{
                [_datePicker setDatePickerMode:(UIDatePickerMode)self.mode];
                [_pickerView addSubview:_datePicker];
                break;
            }
            default:
                break;

        }
    }
    return _datePicker;
}
/**
 Description

 @param mode mode description
 @return return value description
 */
- (id) initWithMode:(TGDatePickerMode)mode title:(NSString *)title{
    if (self = [super initWithStyle:[[TGDatePickerViewStyle alloc] init]]) {
        _mode = mode;
        self.popview = [self popViewWithMode:self.mode title:title];
    }
    return self;
}

- (id) initWithStyle:(__kindof TGDatePickerViewStyle *)style{
    if (self = [super initWithStyle:style != nil ? style : [[TGDatePickerViewStyle alloc] init]]){
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (NSDate *) getPickerViewDate{
    NSString *timeStr = nil;
    TGDateItem dateitem = [self nowDateItem];
    switch (self.mode) {
        case TGDatePickerModeTime:
        case TGDatePickerModeDate:
        case TGDatePickerModeDateAndTime:
        case TGDatePickerModeCountDownTimer:
            return self.datePicker.date;
        case TGDatePickerModeYearMonthDayHourMinute:{
            dateitem.year = [self yearWithRow:[self.dataPicker selectedRowInComponent:0]];
            dateitem.mothon = [self mothonWithRow:[self.dataPicker selectedRowInComponent:1 * 2] year:dateitem.year];
            dateitem.day = [self dayWithRow:[self.dataPicker selectedRowInComponent:2 * 2]     year:dateitem.year month:dateitem.mothon];
            dateitem.hour = [self hourWithRow:[self.dataPicker selectedRowInComponent:3 * 2] year:dateitem.year month:dateitem.mothon day:dateitem.day];
            dateitem.minute = [self minuteWithRow:[self.dataPicker selectedRowInComponent:4 * 2] year:dateitem.year month:dateitem.mothon day:dateitem.day hour:dateitem.hour];
            break;
        }
        case TGDatePickerModeMonthDayHourMinute:{
            dateitem.year = [self yearWithRow:[self.dataPicker selectedRowInComponent:0 * 2]];
            dateitem.mothon = [self mothonWithRow:[self.dataPicker selectedRowInComponent:1 * 2] year:dateitem.year];
            dateitem.day = [self dayWithRow:[self.dataPicker selectedRowInComponent:2 * 2]     year:dateitem.year month:dateitem.mothon];
            dateitem.hour = [self hourWithRow:[self.dataPicker selectedRowInComponent:3 * 2] year:dateitem.year month:dateitem.mothon day:dateitem.day];
            dateitem.minute = [self minuteWithRow:[self.dataPicker selectedRowInComponent:4 * 2] year:dateitem.year month:dateitem.mothon day:dateitem.day hour:dateitem.hour];
            break;
        }
        case TGDatePickerModeYearMonthDay:{
            dateitem.year = [self yearWithRow:[self.dataPicker selectedRowInComponent:0 * 2]];
            dateitem.mothon = [self mothonWithRow:[self.dataPicker selectedRowInComponent:1 * 2] year:dateitem.year];
            dateitem.day = [self dayWithRow:[self.dataPicker selectedRowInComponent:2 * 2]     year:dateitem.year month:dateitem.mothon];
            break;
        }
        case TGDatePickerModeYearMonth:{
            dateitem.year = [self yearWithRow:[self.dataPicker selectedRowInComponent:0 * 2]];
            dateitem.mothon = [self mothonWithRow:[self.dataPicker selectedRowInComponent:1 * 2] year:dateitem.year];
            break;
        }
        case TGDatePickerModeMonthDay:{
             dateitem.mothon = [self mothonWithRow:[self.dataPicker selectedRowInComponent:0 * 2] year:dateitem.year];
            dateitem.day = [self dayWithRow:[self.dataPicker selectedRowInComponent:1 * 2] year:dateitem.year month:dateitem.mothon];
            break;
        }
        case TGDatePickerModeHourMinute:{
            dateitem.hour = [self hourWithRow:[self.dataPicker selectedRowInComponent:0 * 2] year:dateitem.year month:dateitem.mothon day:dateitem.day];
            dateitem.minute = [self minuteWithRow:[self.dataPicker selectedRowInComponent:1 * 2] year:dateitem.year month:dateitem.mothon day:dateitem.day hour:dateitem.hour];
            break;
        }
    }
    timeStr = [NSString stringWithFormat:@"%04ld%02ld%02ld%02ld%02ld",dateitem.year,dateitem.mothon,dateitem.day,dateitem.hour,dateitem.minute];
    if (timeStr != nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmm"];
        [formatter setTimeZone:[NSTimeZone
                                systemTimeZone]];
        return [formatter dateFromString:timeStr];
    }
    return [NSDate date];
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [(TGDatePickerViewStyle *)self.style pickerRowHeight];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat retWidth = 0;
    if (component % 2 != 0) {
        retWidth = TitleWidth;
    }
    else {
        CGFloat pk_w = CGRectGetWidth(pickerView.frame);
        NSInteger num = [self numberByMode];
        num = num >> 1;
        retWidth = (pk_w + PIKERVIEWSYSPACING) / (CGFloat) num - TitleWidth - PIKERVIEWSYSPACING * 2.0;
    }
    return retWidth;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self pickerTitleForRow:row forComponent:component];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger dateComponent = component >> 1;
    switch (self.mode) {
        case TGDatePickerModeTime:
            break;
        case TGDatePickerModeDate:
            break;
        case TGDatePickerModeDateAndTime:
            break;
        case TGDatePickerModeCountDownTimer:
            break;
        case TGDatePickerModeYearMonthDayHourMinute:{
            switch (dateComponent) {
                case 0:
                    [pickerView reloadComponent:1 * 2];
                case 1:
                    [pickerView reloadComponent:2 * 2];
                    break;
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeMonthDayHourMinute:{
            switch (dateComponent) {
                case 0:
                    [pickerView reloadComponent:1 * 2];
                    break;
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeYearMonthDay:{
            switch (dateComponent) {
                case 0:
                    [pickerView reloadComponent:1 * 2];
                case 1:
                    [pickerView reloadComponent:2 * 2];
                    break;
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeYearMonth:{
            switch (dateComponent) {
                case 0:
                    [pickerView reloadComponent:1 * 2];
                    break;
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeMonthDay:{
            switch (dateComponent) {
                case 0:
                    [pickerView reloadComponent:1 * 2];
                    break;
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeHourMinute:
            break;
    }
}
- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *text = [self pickerTitleForRow:row forComponent:component];
    CGSize size = [pickerView rowSizeForComponent:component];
    CGRect frame = CGRectZero;
    frame.size = size;
    if (component % 2 != 0) {
        UIView *view = [[UIView alloc] initWithFrame:frame];
        [view setBackgroundColor:[UIColor clearColor]];

//        view.backgroundColor = row % 2 == 0 ?[UIColor lightGrayColor]:[UIColor whiteColor];
        return view;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:frame];;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
//    label.backgroundColor = row % 2 == 0 ?[UIColor lightGrayColor]:[UIColor whiteColor];
    return label;
//    return view;
}

- (void)changeSpearatorLineColor{
    for(UIView *speartorView in self.dataPicker.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = [UIColor colorWithRed:220/255. green:220/255. blue:220/255. alpha:1.];//隐藏分割线
        }
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSInteger number = [self numberByMode];
    return number;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    TGDateItem item = [self nowDateItem];

    if ((component % 2) != 0) {
        return 10;
    }
    NSInteger dataComponent = component >> 1;
    NSInteger number = 10;
    switch (self.mode) {
        case TGDatePickerModeTime:
        case TGDatePickerModeDate:
        case TGDatePickerModeDateAndTime:
        case TGDatePickerModeCountDownTimer:
            break;
        case TGDatePickerModeYearMonthDayHourMinute:{
            switch (dataComponent) {
                case 0:
                    number = 200;break;
                case 1:
                    number = 12;break;
                case 2:
                    number = 24;break;
                case 3:
                    number = 60;break;
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeMonthDayHourMinute:{
            switch (dataComponent) {
                case 0:
                    number = 12;break;
                case 1:
                    number = 30;break;
                case 2:
                    number = 24;break;
                case 3:
                    number = 60;break;
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeYearMonthDay:{
            switch (dataComponent) {
                case 0:
                    number = 200;break;
                case 1:
                    number = 12;break;
                case 2:{
                    item.year = [self yearWithRow:[pickerView selectedRowInComponent:0 * 2]];
                    item.mothon = [self mothonWithRow:[pickerView selectedRowInComponent:1 * 2] year:item.year];
                    return [self returnDaysInYear:item.year Month:item.mothon];
                }
                default:
                    break;
            }
            break;
        }
        case TGDatePickerModeYearMonth:
            number = 10;break;
        case TGDatePickerModeMonthDay:
            number = 10;break;
        case TGDatePickerModeHourMinute:
            number = 10;break;
    }
    return number;
}

//获取某年某月的天数
- (NSInteger) returnDaysInYear:(NSInteger)year Month:(NSInteger)month{
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * date = nil;
    if(month){
        //        NSDateComponents* comp = [calendar components: NSCalendarUnitYear
        //                                             fromDate:[NSDate date]];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM"];
        NSString * dateStr = [NSString stringWithFormat:@"%ld-%02ld",(long)year,(long)month];
        date = [formatter dateFromString:dateStr];
    }

    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date?:[NSDate date]];
    return days.length;
}
- (void) addLabelWithName:(NSArray *)nameArr number:(NSInteger)number{
    CGRect lableFrame = CGRectZero;
    UIView *lableView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.dataPicker.frame), TitleWidth)];
    [self.dataPicker addSubview:lableView];
    CGFloat originX = 0;
    for (int i = 0; i < number; i++) {
        NSInteger titleNum = i / 2.0;
        CGSize rowSize = [self.dataPicker rowSizeForComponent:i];
        lableFrame.size.width = rowSize.width;
        lableFrame.size.height = rowSize.height;
        if ((i % 2) != 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:lableFrame];
            label.textAlignment = NSTextAlignmentLeft;
            if (titleNum < nameArr.count) {
                label.text = nameArr[titleNum];
            }
            [lableView addSubview:label];
        }
        originX += rowSize.width + PIKERVIEWSYSPACING;
        lableFrame.origin.x = originX;
    }
    CGRect frame = lableView.frame;
    frame.size.height = lableFrame.size.height;
    lableView.frame = frame;
    lableView.center = CGPointMake(lableView.center.x, CGRectGetHeight(self.dataPicker.frame) / 2.0);
}

-(void)addLabelWithName:(NSArray *)nameArr {
    CGRect lableFrame = CGRectZero;
    CGFloat lablHeight = 15;
    NSInteger number = [self numberByMode];
    CGSize rowSize = [self.dataPicker rowSizeForComponent:0];
    lableFrame.origin.x = rowSize.width;
    lableFrame.origin.y = self.dataPicker.frame.size.height/2 - lablHeight / 2.0;
    lableFrame.size.height = rowSize.height;
    for (NSInteger i = 0; i < number; i++) {

    }
}

#pragma mark - 动作

/**
 按钮响应事件

 @param sender 触发zhe
 */
- (IBAction) buttonClick:(id)sender{
    NSDate *date = [self getPickerViewDate];

    if (self.maxDate != nil && [date compare:self.maxDate] == NSOrderedDescending) {
        if (self.errorBlock != nil) {
            if (self.errorBlock(TGDatePickerViewSelectErrorLaterMax)) {
                [self dissm];
            };
        }
        return;
    }
    else if (self.minDate != nil && [date compare:self.maxDate] == NSOrderedAscending) {
        if (self.errorBlock != nil) {
            if (self.errorBlock(TGDatePickerViewSelectErrorEarlierMin)) {
                [self dissm];
            };
        }
        return;
    }
    self.block([self getPickerViewDate]);
    [self dissm];
}

#pragma mark - block action

/**
 创建
 */
+ (TGDatePickerView * (^)(TGDatePickerMode))createmode{
    return ^(TGDatePickerMode model){
        return [[self alloc] initWithMode:model title:@""];
    };
}

/**
 设置标题
 */
- (TGDatePickerView * (^)(NSString *))titleSet{
    return ^(NSString * titleSet){
        self.titleLabel.text = titleSet;
        return self;
    };
}
/**
 显示
 */

//
//- (TGPickerView * (^)(void))show{
//    return ^id(void){
//        [self show]
//        return self;
//        return self.showView(nil);
//    };
//}

- (TGDatePickerView * (^)(NSDate *))maxDateSet{
    return ^id(NSDate *maxDateSet){
        self.maxDate = maxDateSet;
        return self;
    };
}
/**
 设置回调
 */
- (TGDatePickerView * (^)(TGDatePickerViewBlock))blockSet{
    return ^id(TGDatePickerViewBlock blockSet){
        self.block = blockSet;
        return self;
    };
}
/**
 设置日期选择错误回调
 */
- (TGDatePickerView * (^)(TGDatePickerViewErrorBlock))errorBlockSet{
    return ^id(TGDatePickerViewErrorBlock errorBlockSet){
        self.errorBlock = errorBlockSet;
        return self;
    };
}



@end
