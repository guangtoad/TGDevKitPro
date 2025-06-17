//
//  TGDatePickerView.h
//  smartGLink_cn
//
//  Created by toad on 2018/3/15.
//  Copyright © 2018年 toad. All rights reserved.
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

/** 样式 */
@interface TGDatePickerViewStyle : TGPopViewStyle

/** 日期选择样式 */
@property (nonatomic,assign) TGDatePickerMode model;
/** 头部高度 */
@property (nonatomic,assign) CGFloat headerHgiht;
/** 头部背景色 */
@property (nonatomic,strong) UIColor *headerBackgroundColor;
/** 背景颜色 */
@property (nonatomic,strong) UIColor *viewBackGroundColor;
/** 标题字体 */
@property (nonatomic,assign) UIFont *titleFont;
/** 标题颜色 */
@property (nonatomic,strong) UIColor *titleColor;
/** 确定按钮字体 */
@property (nonatomic,strong) UIFont *confirmButtonFont;
/** 确定按钮文字 */
@property (nonatomic,strong) NSString *confirmButtonTxt;
/** 确定按钮颜色 */
@property (nonatomic,strong) NSString *confirmButtonTxtColor;
/** 选择框高度 */
@property (nonatomic,assign) CGFloat pickerHeight;
/** 选择框字体 */
@property (nonatomic,strong) UIFont *pickerFont;
/** picker Row 高度 */
@property (nonatomic,assign) CGFloat pickerRowHeight;
/** 悬着框语言样式 */
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
///**
// 设置模型
// */
//- (TGDatePickerView * (^)(TGDatePickerMode))modeSet;
/**
 设置标题
 */
- (TGDatePickerView * (^)(NSString *))titleSet;
///**
// 设置日期格式
// */
//- (TGDatePickerView * (^)(NSString *))dateFormatSet;
///**
// 显示到view
// */
//- (TGDatePickerView * (^)(UIView *))showView;
/**
 显示
*/
//- (TGDatePickerView * (^)(BOOL))show;
/**
 设置时间设置
 */
- (TGDatePickerView * (^)(NSDate *))dateSet;
/**
 最大显示日期
 */
- (TGDatePickerView * (^)(NSDate *))maxShowDateSet;
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
 设置最大选择日期
 */
- (TGDatePickerView * (^)(NSDate *))maxDateSet;
- (TGDatePickerView * (^)(NSDate *))minDateSet;
- (TGDatePickerView *) addCancelBtnColor:(UIColor *)color;

@end
