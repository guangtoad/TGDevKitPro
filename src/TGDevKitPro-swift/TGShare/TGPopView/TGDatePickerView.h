//
//  TGDatePickerView.h
//  smartGLink_cn
//
//  Created by home on 2018/3/15.
//  Copyright © 2018年 TechnoASKA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGPopView.h"
typedef struct {
    NSInteger year;
    NSInteger mothon;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
    NSInteger weekday;
}TGDateItem;
typedef NS_ENUM(NSInteger,TGDatePickerMode ) {
    TGDatePickerModeTime =  UIDatePickerModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
    TGDatePickerModeDate = UIDatePickerModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
    TGDatePickerModeDateAndTime = UIDatePickerModeDateAndTime,    ///> Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
    TGDatePickerModeCountDownTimer = UIDatePickerModeCountDownTimer,
    TGDatePickerModeYearMonthDayHourMinute,///< 年月日时分
    TGDatePickerModeMonthDayHourMinute,///< 月日时分
    TGDatePickerModeYearMonthDay,///< 年月日
    TGDatePickerModeYearMonth,///< 年月
    TGDatePickerModeMonthDay,///< 月日
    TGDatePickerModeHourMinute///< 时分

};
typedef NS_ENUM(NSInteger,TGDatePickerViewSelectCode ) {
    TGDatePickerViewSelectNode =  0,
    TGDatePickerViewSelectErrorEarlierMin,
    TGDatePickerViewSelectErrorLaterMax,
};

typedef void (^TGDatePickerViewBlock)(NSDate *date);

//typedef void (^TGDatePickerViewBlock)(NSString *str);
typedef BOOL (^TGDatePickerViewErrorBlock)(TGDatePickerViewSelectCode code);

@interface TGDatePickerViewStyle : TGPopViewStyle

@property (nonatomic,assign) TGDatePickerMode model;

@property (nonatomic,assign) CGFloat headerHgiht;
@property (nonatomic,strong) UIColor *headerBackgroundColor;
@property (nonatomic,strong) UIColor *viewBackGroundColor;
@property (nonatomic,assign) UIFont *titleFont;
@property (nonatomic,strong) UIColor *titleColor;

@property (nonatomic,strong) UIFont *confirmButtonFont;
@property (nonatomic,strong) NSString *confirmButtonTxt;
@property (nonatomic,strong) NSString *confirmButtonTxtColor;
@property (nonatomic,assign) CGFloat pickerHeight;
@property (nonatomic,strong) UIFont *pickerFont;
@property (nonatomic,assign) CGFloat pickerRowHeight;
@property (nonatomic,strong) NSLocale *pickerLocale;
@property (nonatomic,strong) TGDatePickerViewBlock block;

@end
/**
 数据选择器
 */
@interface TGDatePickerView : TGPopView

/**
 创建
 */
+ (TGDatePickerView * (^)(TGDatePickerMode))createmode;
/**
 设置模型
 */
- (TGDatePickerView * (^)(TGDatePickerMode))modeSet;
/**
 设置标题
 */
- (TGDatePickerView * (^)(NSString *))titleSet;
/**
 设置日期格式
 */
- (TGDatePickerView * (^)(NSString *))dateFormatSet;
/**
 显示到view
 */
- (TGDatePickerView * (^)(UIView *))showView;
/**
 显示
*/
//- (TGDatePickerView * (^)(BOOL))show;
/**
 设置时间设置
 */
- (TGDatePickerView * (^)(NSDate *))dateSet;
/**
 设置block
 */
- (TGDatePickerView * (^)(TGDatePickerViewBlock))blockSet;

/**
 设置日期选择错误block
 */
- (TGDatePickerView * (^)(TGDatePickerViewErrorBlock))errorBlockSet;

/**
 Description

 @param mode mode description
 @return return value description
 */
- (id) initWithMode:(TGDatePickerMode)mode title:(NSString *)title;

/**
 <#Description#>
 */
- (TGDatePickerView * (^)(NSDate *))maxDateSet;
@end
