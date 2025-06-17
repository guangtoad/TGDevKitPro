//
//  ShareView.m
//  smartGLink_cn
//
//  Created by home on 2018/3/30.
//  Copyright © 2018年 TechnoASKA. All rights reserved.
//

#import "TGShareView.h"
//#define AnimateWithDuration 0.15
@interface TGShareView ()
@property (nonatomic,strong) id<TGShareViewDelegate> delegate;


@end

@implementation TGShareView

- (id) init{
    if (self = [self initWithCancelButtonTitle:@"取消" imageArray:[[self class] imageArray]]) {

    }
    return self;
}
+ (NSArray *)imageArray{
    return @[@"微信"
      ,@"朋友圈"
      ,@"qq"
      ,@"微博"
      ,@"更多"
      ];
}

- (UIView *) shareBtnsViewWithArray:(NSArray *)imageArray{

    CGRect frame = CGRectMake(self.styel.leftMargins, 0, CGRectGetWidth(self.frame) - self.styel.leftMargins - self.styel.rightMargins, self.styel.rowHegiht);

    UIView *contextView = [[UIView alloc] initWithFrame:frame];
    if (self.styel.cornerRadius != 0) {
        contextView.layer.masksToBounds = true;
        contextView.layer.cornerRadius = self.styel.cornerRadius;
    }
    contextView.backgroundColor = self.styel.btnBackgroudColor;
    if (imageArray != nil && imageArray.count > 0) {
        NSInteger num = imageArray.count;
        CGFloat w = CGRectGetWidth(frame) / (num + 1);
        int i = 0;
        for (NSString *imageName in imageArray) {
            UIButton *s_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *btnImg = [UIImage imageNamed:imageName];
            CGSize imageSize = btnImg.size;
            CGRect btnFrame =  CGRectMake(0, 0, imageSize.width, imageSize.height);
            [s_btn setImage:btnImg forState:UIControlStateNormal];
            [s_btn setFrame:btnFrame];
            [s_btn setCenter:CGPointMake(w * (i + 1), CGRectGetHeight(frame) / 2.0)];
            s_btn.tag = 90 + (i++);
            [s_btn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
            [contextView addSubview:s_btn];
        }
    }
    return contextView;
}

- (id) initWithCancelButtonTitle:(NSString *)cancelButtonTitle imageArray:(NSArray *)imageArray{
    if (self = [super initWithStyle:nil]) {
        UIView *contextView = [self shareBtnsViewWithArray:imageArray];
        UIView *popView = [self popViewTitle:nil cancelButtonTitle:cancelButtonTitle contextView:contextView];
        self.popview = popView;
    }
    return self;
}
- (IBAction) btn_click:(id)sender{

}

@end

