//
//  TGSheetView.h
//  TGShare
//
//  Created by toad on 2018/4/15.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGPopView.h"

/**
 Description

 @param index index description
 */
typedef void (^TGSheetViewSelectBlock)(NSInteger index);

/**
 TGSheetViewStyle
 */
@interface TGSheetViewStyle : TGPopViewStyle

/** 圆角 */
@property (nonatomic,assign) CGFloat cornerRadius;
/** row height */
@property (nonatomic,assign) CGFloat rowHegiht;

/** 左边距 */
@property (nonatomic,assign) CGFloat leftMargins;
/** 右边距 */
@property (nonatomic,assign) CGFloat rightMargins;
/** 下边距 */
@property (nonatomic,assign) CGFloat bottomMargins;
/** 上边距 */
@property (nonatomic,assign) CGFloat topMargins;

/** 间距 */
@property (nonatomic,assign) CGFloat spacing;
/** 遮罩背景色 */
@property (nonatomic,assign) UIColor *maskBackgrouColor;
/** 标题字体 */
@property (nonatomic,strong) UIFont *titleFont;
/** 标题颜色 */
@property (nonatomic,strong) UIColor *titleColor;
/** 标题高度 */
@property (nonatomic,assign) CGFloat titleHegiht;
/** 按钮文字颜色 */
@property (nonatomic,strong) UIColor *btnTitleColor;
/** 按钮 */
@property (nonatomic,strong) UIFont *btnTitleFont;
/** 按钮背景色 */
@property (nonatomic,strong) UIColor *btnBackgroudColor;

@end

/**
 TGSHeetView
 */
@interface TGSheetView : TGPopView

/** 样式 */
@property (nonatomic,strong) TGSheetViewStyle *styel;
/** block */
@property (nonatomic, copy) TGSheetViewSelectBlock block;
/** 子页面 */
@property (nonatomic,strong) __kindof UIView *contextView;

/**
 Description

 @param style style description
 @return return value description
 */
- (id) initWithStyle:(TGSheetViewStyle *)style;
/**
 Description

 @param style style description
 @param title title description
 @param cancelButtonTitle cancelButtonTitle description
 @param contextView contextView description
 @return return value description
 */
- (id) initWithStyle:(TGSheetViewStyle *)style
               Title:(NSString *)title
   cancelButtonTitle:(NSString *)cancelButtonTitle
         contextView:(__kindof UIView *)contextView;

/**
 Description

 @param style style description
 @param title title description
 @param cancelButtonTitle cancelButtonTitle description
 @param otherButtons otherButtons description
 @param block block description
 @return return value description
 */
- (id) initWithStyle:(TGSheetViewStyle *)style
               Title:(NSString *)title
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSArray *)otherButtons
    actionSheetBlock:(TGSheetViewSelectBlock)block;

/**
 Description

 @param title title description
 @param cancelButtonTitle cancelButtonTitle description
 @param contextView contextView description
 @return return value description
 */
- (UIView *) popViewTitle:(NSString *)title
        cancelButtonTitle:(NSString *)cancelButtonTitle
              contextView:(__kindof UIView *)contextView;
@end
