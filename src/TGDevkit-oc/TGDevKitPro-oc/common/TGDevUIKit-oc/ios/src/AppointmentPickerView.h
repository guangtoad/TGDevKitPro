//
//  AppointmentPickerView.h
//  smartGLink_cn
//
//  Created by zhangshaoxia on 16/11/29.
//  Copyright © 2016年 TechnoASKA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickerType) {
    TimePicker,
    ProjectPicker
};
@protocol AppointmentViewDelegate <NSObject>

- (void)userClickConfrm:(PickerType)pickerType withProjectName:(NSInteger )projectName withYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day withTime:(NSInteger)time;

@end

@interface AppointmentPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) PickerType pickerType;
@property (nonatomic, assign) id<AppointmentViewDelegate> delegate;
@property (nonatomic, assign) NSInteger days;//选择月份的天数
@property (nonatomic, assign) NSInteger currentYear;//当前年份
@property (nonatomic, assign) NSInteger year;//选择的年份
@property (nonatomic, assign) NSInteger month;//选择的月份
@property (nonatomic, assign) NSInteger day;//选择的日期
@property (nonatomic, assign) NSInteger time;//上下午 0：上午 1：下午
@property (nonatomic, assign) NSInteger projectName;//项目名称
@property (nonatomic, assign) NSInteger currentMonth;//当前月份
- (id)initWithFrame:(CGRect)frame withPickerType:(PickerType)type;
- (void) setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour;
- (void) setProjectNumber:(NSInteger)porjectNumber;

- (void) setSelectTimeIntervalSince1970:(NSTimeInterval)timeInterval;
- (void) setSelectTimeIntervalNow;

@end
