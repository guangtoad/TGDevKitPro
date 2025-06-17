//
//  TGDorpMenu.h
//  TGShare
//
//  Created by home on 2018/5/18.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGPopView.h"

@interface TGDorpMenuStyle : TGPopViewStyle

@property (nonatomic,assign) CGSize menuSize;
@property (nonatomic,assign) CGSize iconSize;
@property (nonatomic,strong) UIColor *lenColor;
@property (nonatomic,strong) UIColor *menuColor;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *menuTrintColor;
@property (nonatomic,strong) UIFont *menuFont;
@property (nonatomic,assign) UIEdgeInsets menuItemInsets;

@property (nonatomic,assign) NSInteger showType;
/** row height */
@property (nonatomic,assign) CGFloat rowHegiht;
/** 圆角 */
@property (nonatomic,assign) CGFloat cornerRadius;
/** 左边距 */
@property (nonatomic,assign) CGFloat leftMargins;
/** 右边距 */
@property (nonatomic,assign) CGFloat rightMargins;
/** 下边距 */
@property (nonatomic,assign) CGFloat bottomMargins;
/** 上边距 */
@property (nonatomic,assign) CGFloat topMargins;
/** 三角形高度 */
@property (nonatomic,assign) CGFloat arrowHeight;
/** 三角形偏移量 */
@property (nonatomic,assign) CGFloat arrowOffset;

@end

UIKIT_EXTERN const NSString * _Nonnull MenuItemKeyImageName;
UIKIT_EXTERN const NSString * _Nonnull MenuItemKeyTitle;

/**
 Description

 @param index index description
 */
typedef void (^TGDorpMenuBlock)(NSInteger index);

NS_INLINE NSDictionary *menuItem(NSString *imageName,NSString *title){
    return [[NSDictionary alloc] initWithObjectsAndKeys:
     imageName != nil ? imageName : @"",MenuItemKeyImageName
     ,title != nil ? title : @"",MenuItemKeyTitle
     , nil];
}

@interface TGDorpMenuArrow : UIView
@end



@interface TGDorpMenu : TGPopView

- (id) initWithStyle:(TGDorpMenuStyle *)style
              sender:(NSObject *)sender
           dataArray:(NSArray<NSDictionary *> *)dataArray
               block:(TGDorpMenuBlock)block;

- (id) initWithStyle:(TGDorpMenuStyle *)style sender:(NSObject *)sender;
- (id) initWithSender:(NSObject *)sender dataArray:(NSArray<NSDictionary *> *)dataArray block:(TGDorpMenuBlock)block;
- (id) initWithSender:(NSObject *)sender dataArray:(NSArray<NSDictionary *> *)dataArray;
- (id) initWithSender:(NSObject *)sender;

@end
