//
//  TGPopView.h
//  TGShare
//
//  Created by toad on 2018/4/15.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 样式
 */
@interface TGPopViewStyle : NSObject
/** 动画市场 */
@property (nonatomic,assign) CGFloat animateDuration;
/** 背景颜色 */
@property (nonatomic,strong) UIColor *backgroundColor;

@end
/**
 TGPopView
 */
@interface TGPopView : UIControl
/** 样式 */
@property (nonatomic,strong) __kindof TGPopViewStyle *style;
/** pop view */
@property (nonatomic,strong) __kindof UIView *popview;
/** touch dissm */
@property (nonatomic,assign) BOOL touchWinDissm;
/**
 创建
 */
+ (TGPopView * (^)(void))createObj;
+ (TGPopView * (^)(TGPopViewStyle *))createObjByStyle;
/**
 显示view
 */
- (__kindof TGPopView * (^)(__kindof UIView *))showPopview;

- (id) initWithStyle:(TGPopViewStyle *)style;
/**
 展示

 @param animations 动画
 @return return value description
 */
- (BOOL) showAnimations:(void (^)(void))animations;

/**
 展示
 */
- (BOOL) show;

/**
 消失
 */
- (void) dissm;

/**
 消失

 @param animations 动画
 */
- (void) dissmAnimations:(void (^)(void))animations;

+ (void) clearAllPopView;

@end
