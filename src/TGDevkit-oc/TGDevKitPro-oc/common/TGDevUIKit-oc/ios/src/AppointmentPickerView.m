//
//  AppointmentPickerView.m
//  smartGLink_cn
//
//  Created by zhangshaoxia on 16/11/29.
//  Copyright © 2016年 TechnoASKA. All rights reserved.
//

#import "AppointmentPickerView.h"

#define TIMEPICKER 1 //时间选择器 轮询次数

#define COM_YEAR    1
#define COM_MONTH   3
#define COM_DAY     5
#define COM_TIME    7
@interface AppointmentPickerView ()
@property (nonatomic,strong) NSArray *timeArray;
@end

@implementation AppointmentPickerView

- (void) setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour{
    self.days = [self returnDaysInMonth:0];
    self.year = year;
    self.currentYear = year;
    self.currentMonth = month;
    self.time = hour;
    self.month = month;
    //往后一天，当天算来年的
    self.day = day;
    //如果日期 大于本月的天数
    if(self.day > self.days){
        //日期变为1号
        self.day = 1;
        //月份加1
        self.month = month + 1;
        self.currentMonth = self.month;
        //如果月份大于12月
        if(self.month > 12){
            //月份变为1
            self.year += 1;
            self.currentYear += 1;
            self.month = 1;
            self.currentMonth = 1;
        }
        //月份变化，重新结算本月多少天
        self.days = [self returnDaysInMonth:self.month];
    }
    if (self.pickerType == TimePicker) {
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:0 inComponent:1 animated:NO];

        [self.pickerView selectRow:self.month - 1 inComponent:COM_MONTH animated:NO];
        [self.pickerView selectRow:self.day - 1 inComponent:COM_DAY animated:NO];
        [self.pickerView selectRow:self.time inComponent:COM_TIME animated:NO];
    }
}

- (void) setProjectNumber:(NSInteger)porjectNumber{
    self.projectName = porjectNumber;
    if (self.pickerType == ProjectPicker) {
        
        [self.pickerView selectRow:self.projectName - 1 inComponent:0 animated:NO];
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
- (NSArray *) timeArray{
    if (!_timeArray) {
        _timeArray =
        [[NSArray alloc] initWithObjects:@"0:00",@"1:00",@"2:00",@"3:00",@"4:00",@"5:00",@"6:00",@"7:00",@"8:00",@"9:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",nil];
    }
    return _timeArray;
}

- (id)initWithFrame:(CGRect)frame withPickerType:(PickerType)type
{
    if(self == [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.pickerType = type;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-1, 0,[UIScreen mainScreen].bounds.size.width + 2, 44)];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
//        self.titleLabel.layer.borderColor = [UIColor colorWithRed:220/255. green:220/255. blue:220/255. alpha:1].CGColor;
//        self.titleLabel.layer.borderWidth = 1.0;
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
    }
    return self;
}

- (void)setPickerType:(PickerType)pickerType
{
    _pickerType = pickerType;
    if(pickerType == TimePicker){
        self.titleLabel.text = @"请选择到店时间";
        NSCalendar *gregorian = [[[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian] autorelease];
        // 获取当前日期
        NSDate* date = [NSDate new];
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        NSDateComponents* comp = [gregorian components: unitFlags
                                              fromDate:date];
        self.days = [self returnDaysInMonth:0];
        self.year = comp.year;
        self.currentYear = comp.year;
        self.currentMonth = comp.month;
        self.time = comp.hour;
        self.month = comp.month;
        //往后一天，当天算来年的
        self.day = comp.day + 1;
        //如果日期 大于本月的天数
        if(self.day > self.days){
            //日期变为1号
            self.day = 1;
            //月份加1
            self.month = comp.month + 1;
            self.currentMonth = self.month;
            //如果月份大于12月
            if(self.month > 12){
                //月份变为1
                self.year += 1;
                self.currentYear += 1;
                self.month = 1;
                self.currentMonth = 1;
            }
            //月份变化，重新结算本月多少天
            self.days = [self returnDaysInMonth:self.month];
        }
        
        self.time = 0;
        
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:0 inComponent:COM_YEAR animated:NO];
//        [self setYear:self.year month:self.month day:self.day hour:self.time];
        
       
    }else{
        self.titleLabel.text = @"请选择保养项目";
        self.projectName = 1;
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
    }
    
}

- (void)buttonClick:(UIButton *)button
{
//    NSInteger year = 0;
    if(self.pickerType == TimePicker){
        NSDateFormatter * formmater = [[NSDateFormatter alloc] init];
        formmater.dateFormat = @"yyyyMMddHH:MM";
        NSString * currentTimeStr = [formmater stringFromDate:[NSDate date]];
        
        NSString * selectedTimeStr = [NSString stringWithFormat:@"%ld%02ld%02ld%02ld:00",(long)self.year,(long)self.month,(long)self.day,(long)self.time];
        if([currentTimeStr compare:selectedTimeStr options:NSNumericSearch] != NSOrderedAscending){
           
            return;
        }
        
        /*
        NSCalendar *calendar = [[[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian] autorelease];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond | NSWeekCalendarUnit | NSCalendarUnitWeekday;
        NSDateComponents * nowComp = [calendar components:unitFlags fromDate:[NSDate date]];
        if(self.month > nowComp.month){
            year = nowComp.year;
        }else if(self.month < nowComp.month){
            year = nowComp.year + 1;
        }else if(self.month == nowComp.month){
            if(self.day > nowComp.day){
                year = nowComp.year;
            }else if(self.day <= nowComp.day){
                year = nowComp.year + 1;
                [CommonDialog showAlertViewTitle:nil message:@"预约时间为过去时间，请重新选择。" delegate:nil tag:1 otherButtonTitles:nil cancelButtonTitle:@"OK"];
                return;
            }
         */
//            else if(self.day == nowComp.day){
//                if(nowComp.hour >= 12){
//                    year = nowComp.year + 1;
//                }else{
//                    if(self.time){
//                        year = nowComp.year;
//                    }else{
//                        year = nowComp.year + 1;
//                    }
//                }
//            }
        /*
        }
         */
//        if(self.month < nowComp.month || (self.month == nowComp.month && self.day < nowComp.day) || (self.month == nowComp.month && self.day == nowComp.day && self.time <= (nowComp.hour >= 12?1:0))){
//            //note:zhangshaoxia 解决弹出alert，回到主屏幕再回来，alert还存在的问题
//            [CommonDialog showAlert:DLG_SELECTEDTIME_ERR delegate:nil tag:1];
//            return;
//        }
    }
    
    if([self.delegate respondsToSelector:@selector(userClickConfrm:withProjectName:withYear:withMonth:withDay:withTime:)]){
        [self.delegate userClickConfrm:self.pickerType withProjectName:self.projectName withYear:self.year withMonth:self.month withDay:self.day withTime:self.time];
//        [self.delegate userClickConfrm:self.pickerType string:self.pickerType?[NSString stringWithFormat:@"%ld万公里",(long)self.projectName]:[NSString stringWithFormat:@"%02ld月%02ld日 %@",(long)self.month,(long)self.day,self.time?@"下午":@"上午"]];
    }
}

#pragma mark -- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    //    if(component == 0){
    //        return ([UIScreen mainScreen].bounds.size.width - 160-15)/2;
    //    }else if(component == 1){
    //        return 65;
    //    }else if(component == 2){
    //        return 95;
    //    }else if(component == 3){
    //        return ([UIScreen mainScreen].bounds.size.width - 160-15)/2;
    //    }
    //    return 0;
    
    CGSize yearSize = [[self yearForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    CGSize monthSize = [[self monthForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    CGSize daySize = [[self dayForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    CGSize timeSize = [[self timeForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    if(component == 0){
        if (self.pickerType == ProjectPicker) {
            return [UIScreen mainScreen].bounds.size.width;
        }
        return ([UIScreen mainScreen].bounds.size.width -yearSize.width - monthSize.width - daySize.width - timeSize.width - 10-23-33-23 )/2.0;
    }else if(component == 1){
        return yearSize.width;
    }else if(component == 2){
        return 13;
    }else if(component == COM_MONTH){
        return monthSize.width;
    } if(component == 4){
        return 23;
    } if(component == COM_DAY){
        return daySize.width;
    } if(component == 6){
        return 13;
    } if(component == COM_TIME){
        return timeSize.width;
    } if(component == 8){
        return ([UIScreen mainScreen].bounds.size.width -yearSize.width - monthSize.width - daySize.width - timeSize.width - 10 -23-33-23 )/2.0;
    }
    return 0;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(self.pickerType == TimePicker){
        if(component == 0){
            return [NSString stringWithFormat:@"%ld月",(long)row+1];
        }else if(component == 1){
            return [NSString stringWithFormat:@"%ld日",(long)row+1];
        }else{
            return self.timeArray[row];
//            return @[@"上午",@"下午"][row];
        }
    }else{
       return [NSString stringWithFormat:@"%ld万公里",(long)row+1];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.pickerType == TimePicker){
        if(component == COM_YEAR){
            self.year = self.currentYear + row;
            if(self.days == [self returnDaysInMonth:self.month]) return;
            self.days = [self returnDaysInMonth:self.month];
            if(self.day > self.days){
                self.day = self.days;
            }
            [self.pickerView reloadComponent:COM_DAY];
            
        }else if(component == COM_MONTH){
//            self.month = (row%12 +self.currentMonth) > 12 ?(row%12 +self.currentMonth - 12):(row%12 +self.currentMonth);
            self.month = row%12 + 1;
            self.days = [self returnDaysInMonth:self.month];
            if(self.day > self.days){
                self.day = self.days;
            }
            [self.pickerView reloadComponent:COM_DAY];
            [self.pickerView selectRow:self.day - 2 inComponent:COM_DAY animated:NO];
        }else if(component == COM_DAY){
            self.day = row%self.days + 1;
        }else if(component == COM_TIME){
            self.time = row;
        }
    }else{
        self.projectName = row+1;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view  {
    [self changeSpearatorLineColor];
    CGFloat width = 0;
    CGSize yearSize = [[self yearForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    CGSize monthSize = [[self monthForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    CGSize daySize = [[self dayForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    CGSize timeSize = [[self timeForm] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[self labelFontSize]]} context:nil].size;
    if(component == 0){
        width = ([UIScreen mainScreen].bounds.size.width -yearSize.width - monthSize.width - daySize.width - timeSize.width - 10 -23-33-23 )/2.0;
        if (self.pickerType == ProjectPicker) {
            width = [UIScreen mainScreen].bounds.size.width;
        }
    }else if(component == COM_YEAR){
        width = yearSize.width;
    }else if(component == 2){
        width = 13;
    }else if(component == COM_MONTH){
        width = monthSize.width;
    } if(component == 4){
        width = 23;
    } if(component == COM_DAY){
        width = daySize.width;
    } if(component == 6){
        width = 13;
    } if(component == COM_TIME){
        width = timeSize.width;
    } if(component == 8){
        width = ([UIScreen mainScreen].bounds.size.width -yearSize.width - monthSize.width - daySize.width - timeSize.width - 10-23-38-23 )/2.0;
    }
    UILabel *myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 35)] autorelease];
    
    myView.textAlignment = NSTextAlignmentCenter;
    myView.backgroundColor = [UIColor blackColor];
//    myView.text = [pickerNameArray objectAtIndex:row];
    
    if(self.pickerType == TimePicker){
        if(component == COM_YEAR){
//            myView.textAlignment = NSTextAlignmentRight;
            myView.backgroundColor = [UIColor blueColor];
            myView.text =  [NSString stringWithFormat:@"%ld年",self.currentYear+row];
        }else if(component == COM_MONTH){
            //修改日期格式
//            NSInteger monthD = (long)row%12+self.currentMonth;
//            myView.text =  [NSString stringWithFormat:@"%ld月",monthD > 12 ? monthD - 12 : monthD];
            myView.textAlignment = NSTextAlignmentRight;
            myView.backgroundColor = [UIColor yellowColor];
            myView.text =  [NSString stringWithFormat:@"%ld月",row+1];
        }else if(component == COM_DAY){
            myView.backgroundColor = [UIColor redColor];
            myView.textAlignment = NSTextAlignmentRight;
            myView.text =  [NSString stringWithFormat:@"%ld日",(long)row%self.days+1];
        }else if(component == COM_TIME){
            myView.backgroundColor = [UIColor purpleColor];
//            myView.textAlignment = NSTextAlignmentLeft;
            myView.text = self.timeArray[row];
//            myView.text =  @[@"上午",@"下午"][row];
        }
    }else{
        self.projectName = row+1;
       myView.text = [NSString stringWithFormat:@"%ld万公里",(long)row+1];
    }
    myView.font = [UIFont systemFontOfSize:[self labelFontSize]];         //用label来设置字体大小
    myView.backgroundColor = [UIColor clearColor];
    return myView;

}

- (void)changeSpearatorLineColor
{
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
    if(self.pickerType == TimePicker){
        return 9;
    }else if(self.pickerType == ProjectPicker){
        return 1;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(self.pickerType == TimePicker){
        if(component == COM_YEAR){
            return 2;
        }else if(component == COM_MONTH){
            return 12*TIMEPICKER;
        }else if(component == COM_DAY){
            return self.days*TIMEPICKER;
        }else if(component == COM_TIME){
            return self.timeArray.count;
        }
    }else if(self.pickerType == ProjectPicker){
        return 15;
    }
    return 0;
}

//获取某月的天数
- (NSInteger)returnDaysInMonth:(NSInteger)month
{
    NSCalendar *calendar = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];\
    NSDate * date = nil;
    if(month){
        NSDateComponents* comp = [calendar components: NSCalendarUnitYear
                                             fromDate:[NSDate date]];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM"];
        NSString * dateStr = [NSString stringWithFormat:@"%ld-%02ld",(long)self.year,(long)month];
        date = [formatter dateFromString:dateStr];
        [formatter release];
    }
    
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date?:[NSDate date]];
    [calendar release];
    return days.length;
}

- (void)dealloc
{
    if(self.titleLabel != nil){
        [self.titleLabel release];
        self.titleLabel = nil;
    }
    
    if(self.confirmButton != nil){
        [self.confirmButton release];
        self.confirmButton = nil;
    }
    
    if(self.pickerView != nil){
        [self.pickerView release];
        self.pickerView = nil;
    }
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
