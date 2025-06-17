//
//  TGPopView.m
//  TGShare
//
//  Created by toad on 2018/4/15.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGPopView.h"

@implementation TGPopViewStyle : NSObject

- (id) init{
    if (self = [super init]) {
        _animateDuration = 0.3;
        _backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
@interface TGPopView ()
/** 动画 */
@property (nonatomic,assign) BOOL isAminateing;
@end

@implementation TGPopView

- (id) init{
    if (self = [self initWithStyle:nil]) {

    }
    return self;
}

- (id) initWithStyle:(TGPopViewStyle *)style{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds
                ]) {
        self.touchWinDissm = true;
        if (style != nil) {
            self.style = style;
        }
        else {
            self.style = [[TGPopViewStyle alloc] init];
        }
    }
    return self;
}
/**
 构建
 */
+ (TGPopView * (^)(void))createObj{
    return ^id(void){
        return [[TGPopView alloc] initWithStyle:nil];
    };
}
/**
 构建
 */
+ (TGPopView * (^)(TGPopViewStyle *))createObjByStyle{
    return ^id(TGPopViewStyle *style){
        return [[TGPopView alloc] initWithStyle:style];
    };
}
/**
 显示view
 */
- (__kindof TGPopView * (^)(__kindof UIView *))showPopview{
    __weak typeof(self) weakSelf = self;
    return ^id(UIView *showPopview){
        weakSelf.popview = showPopview;
        [weakSelf show];
        return self;
    };
}


/**
 消失

 @param animations 动画
 */
- (void) dissmAnimations:(void (^)(void))animations{
    if (self.popview != nil) {
        if (animations != nil) {
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:self.style.animateDuration
                             animations:animations
                             completion:^(BOOL finished) {
                                 [weakSelf removeFromSuperview];
                             }];
        }
        else {
            CGRect begin_frame = self.popview.frame;
            begin_frame.origin.y = CGRectGetMaxY(self.frame) - CGRectGetHeight(self.popview.frame);

            CGRect end_frame = self.popview.frame;
            end_frame.origin.y =  CGRectGetHeight(self.frame);
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:self.style.animateDuration
                             animations:^{
                                 weakSelf.popview.frame = end_frame;
                             }
                             completion:^(BOOL finished) {
                                 [weakSelf removeFromSuperview];
                             }];
        }
    }
    else {
        [self removeFromSuperview];
    }
}
/**
 消失
 */
- (void) dissm{
    [self setUserInteractionEnabled:false];
    self.isAminateing = false;

    if (self.popview != nil) {

        CGRect begin_frame = self.popview.frame;
        begin_frame.origin.y = CGRectGetMaxY(self.frame) - CGRectGetHeight(self.popview.frame);

        CGRect end_frame = self.popview.frame;
        end_frame.origin.y =  CGRectGetHeight(self.frame);
        [self dissmAnimations:^{
            self.popview.frame = end_frame;
        }];
    }
    else {
        [self removeFromSuperview];
    }
}
/**
展示

 @param animations 动画
 @return return value description
 */
- (BOOL) showAnimations:(void (^)(void))animations{

    UIView *showView = [UIApplication sharedApplication].delegate.window;
    [showView addSubview:self];
//    [[UIApplication sharedApplication].delegate.window viewWithTag:<#(NSInteger)#>]
    if (self.popview != nil) {
        BOOL popUserInteractionEnabled = self.popview.userInteractionEnabled;
        [self.popview setUserInteractionEnabled:false];
        [self addSubview:self.popview];
        if (animations != nil) {
            [UIView animateWithDuration:self.style.animateDuration
                             animations:animations
                             completion:^(BOOL finished) {
                                 self.isAminateing = false;
                                 [self.popview setUserInteractionEnabled:popUserInteractionEnabled];
                                 if (self.touchWinDissm) {
                                     [self addTarget:self action:@selector(dissm) forControlEvents:UIControlEventTouchUpInside];
                                 }
                             }];
        }
        else {
            CGRect begin_frame = self.popview.frame;
            begin_frame.origin.y = CGRectGetHeight(self.frame);

            CGRect end_frame = self.popview.frame;
            end_frame.origin.y = CGRectGetMaxY(self.frame) - CGRectGetHeight(self.popview.frame);

            self.popview.frame = begin_frame;
            self.isAminateing = true;
            [UIView animateWithDuration:self.style.animateDuration
                             animations:^{
                                 self.popview.frame = end_frame;
                             }
                             completion:^(BOOL finished) {
                                 self.isAminateing = false;
                                 [self.popview setUserInteractionEnabled:popUserInteractionEnabled];
                                 if (self.touchWinDissm) {
                                     [self addTarget:self action:@selector(dissm) forControlEvents:UIControlEventTouchUpInside];

                                 }
                             }];
        }
    }
    else {
        [self addTarget:self action:@selector(dissm) forControlEvents:UIControlEventTouchUpInside];
    }
    return true;
}
/**
 展示
 */
- (BOOL) show{
    return [self showAnimations:nil];
    return true;
}

- (void) willRemoveSubview:(UIView *)subview{
    [super willRemoveSubview:subview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TGPOPCLOSEALLVIEW" object:nil];
}

- (void) willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearAllPopViewNotation:) name:@"TGPOPCLOSEALLVIEW" object:nil];
}

- (void) clearAllPopViewNotation:(NSNotification *)not{
    [self dissm];
}

+ (void) clearAllPopView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TGPOPCLOSEALLVIEW" object:nil];
}
@end
