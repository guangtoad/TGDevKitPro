//
//  TGHudView.h
//  smartGLink_cn
//
//  Created by home on 2018-08-09.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGPopView.h"

@interface TGHudViewStyle : TGPopViewStyle

/** 尺寸 */
@property (nonatomic,assign) CGSize hudSize;
/** 颜色 */
@property (nonatomic,strong) UIColor *hudColor;
/** 标题字体 */
@property (nonatomic,strong) UIFont *titleFont;
/** 标题颜色 */
@property (nonatomic,strong) UIColor *titleColor;
/** 自动消失 */
@property (nonatomic,assign) BOOL autoDissm;
/** 自动消失事件 */
@property (nonatomic,assign) CGFloat dissmTime;
/** 圆角 */
@property (nonatomic,assign) CGFloat cornerRadius;

@end

@interface TGHudView : TGPopView

/**
 初始化

 @param style 样式
 @param title 标题
 @param image 图片
 @return self
 */
- (id) initWithStyle:(__kindof TGHudViewStyle *)style title:(NSString *) title image:(UIImage *)image;

@end
