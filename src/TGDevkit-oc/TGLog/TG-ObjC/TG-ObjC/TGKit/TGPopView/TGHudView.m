//
//  TGHudView.m
//  smartGLink_cn
//
//  Created by home on 2018-08-09.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGHudView.h"

@implementation TGHudViewStyle

/**
 初始化

 @return self
 */
- (id) init{
    if (self = [super init]) {
        self.autoDissm = true;
        self.dissmTime = 2;
        self.titleFont = [UIFont systemFontOfSize:19];
        self.hudSize = CGSizeMake(374, 496);
        self.hudColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.titleColor = [UIColor whiteColor];
        self.cornerRadius = 10;
    }
    return self;
}

@end

@implementation TGHudView

/**
 初始化

 @param style 样式
 @return self
 */
- (id) initWithStyle:(__kindof TGHudViewStyle *)style{
    if (self = [super initWithStyle:style != nil ? style : [[TGHudViewStyle alloc] init]]) {
        self.touchWinDissm = false;
    }
    return self;
}
/**
 弹出菜单

 @param title 标题
 @param image 显示图片
 @return popview
 */
- (UIView *) popViewWithTitle:(NSString *)title image:(UIImage *)image{
    CGRect frame = CGRectZero;
    frame.size = [(TGHudViewStyle *)self.style hudSize];
    UIView *popView = [[UIView alloc] initWithFrame:frame];
    popView.backgroundColor = [(TGHudViewStyle *)self.style hudColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLab.text = title;
    titleLab.font = [(TGHudViewStyle *)self.style titleFont];
    titleLab.textColor = [(TGHudViewStyle *)self.style titleColor];
    [titleLab sizeToFit];
    titleLab.center = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame) / 3.);
    [popView addSubview:titleLab];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [popView addSubview:imageView];
    imageView.center = CGPointMake(CGRectGetMidX(frame) , CGRectGetMaxY(frame)/ 3. * 2.);
    popView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));

    if ([(TGHudViewStyle *)self.style cornerRadius] > 0) {
        popView.layer.masksToBounds = true;
        popView.layer.cornerRadius = [(TGHudViewStyle *)self.style cornerRadius];
    }

    return popView;
}
/**
 初始化

 @param style 样式
 @param title 标题
 @param image 图片
 @return self
 */
- (id) initWithStyle:(__kindof TGHudViewStyle *)style title:(NSString *) title image:(UIImage *)image{
    if (self = [self initWithStyle:style]) {
        UIView *popView = [self popViewWithTitle:title image:image];
        self.popview = popView;
    }
    return self;
}

/**
 显示

 @return 显示状态
 */
- (BOOL) show{
    self.popview.alpha = 0.01;
    self.backgroundColor = [UIColor clearColor];
    BOOL ret = [self showAnimations:^{
        self.popview.alpha = 1;
    }];
    if ([(TGHudViewStyle *)self.style autoDissm]) {
        CGFloat delay = [(TGHudViewStyle *)self.style dissmTime];
        [self performSelector:@selector(dissm) withObject:nil afterDelay:delay];
    }
    return ret;
}

/**
 消失
 */
- (void) dissm{
    [super dissmAnimations:^{
        self.popview.alpha = 0.01;
    }];
}
@end
