//
//  TGSheetView.m
//  TGShare
//
//  Created by toad on 2018/4/15.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGSheetView.h"

/**
 TGSHeetViewStyle
 */
@implementation TGSheetViewStyle

- (id) init{
    if (self = [super init]) {
        /** 圆角 */
        _cornerRadius = 10;
        /** row height */
        _rowHegiht = 44;
        /** 左边距 */
        _leftMargins = 15;
        /** 右边距 */
        _rightMargins = 15;
        /** 下边距 */
        _bottomMargins = 15;
        /** 上边距 */
        _topMargins = 15;
        /** 间距 */
        _spacing = 16;
        _maskBackgrouColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        /** 标题字体 */
        _titleFont = [UIFont systemFontOfSize:12];
        /** 标题颜色 */
        _titleColor = [UIColor blackColor];
        /** 标题高度 */
        _titleHegiht = _rowHegiht;
        /** 按钮文字颜色 */
        _btnTitleColor = [UIColor blackColor];
        /** 按钮 */
        _btnTitleFont = [UIFont systemFontOfSize:12];
        /** 按钮背景色 */
        _btnBackgroudColor = [UIColor whiteColor];
    }
    return self;
}

@end

@interface TGSheetView ()<UITableViewDelegate,UITableViewDataSource>

/** 内容 */
@property (nonatomic,strong) NSMutableArray *contextArray;
@end

@implementation TGSheetView

/**
 Description

 @param title title description
 @return return value description
 */
- (__kindof UIButton *) cancelBtnByTitle:(NSString *)title{
    CGRect frame = CGRectZero;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.layer.masksToBounds = true;
    cancelBtn.layer.cornerRadius = self.styel.cornerRadius;
    [cancelBtn addTarget:self action:@selector(dissm) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:title forState:UIControlStateNormal];
    [cancelBtn setTitleColor:self.styel.btnTitleColor forState:UIControlStateNormal];
    cancelBtn.backgroundColor = self.styel.btnBackgroudColor;
    cancelBtn.titleLabel.font = self.styel.btnTitleFont;
    frame.origin.x = self.styel.leftMargins;
    frame.origin.y = 0;
    frame.size.width = CGRectGetWidth(self.frame) - self.styel.leftMargins - self.styel.rightMargins;
    frame.size.height = self.styel.rowHegiht;
    cancelBtn.frame = frame;
    return cancelBtn;
}

/**
 Description

 @return return value description
 */
- (UITableView *) contextTableView{
    CGRect frame = CGRectMake(self.styel.leftMargins, 0, CGRectGetWidth(self.frame) - self.styel.leftMargins - self.styel.rightMargins, 10);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.layer.masksToBounds = true;
    tableView.layer.cornerRadius = self.styel.cornerRadius;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = false;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableView reloadData];
    CGSize contentSize = tableView.contentSize;
    frame.size.height = MIN(contentSize.height, self.styel.rowHegiht * self.contextArray.count);
    tableView.frame = frame;
    return tableView;
}

/**
 Description

 @return return value description
 */
- (NSMutableArray *) contextArray{
    if (!_contextArray) {
        _contextArray = [[NSMutableArray alloc] init];
    }
    return _contextArray;
}

/**
 Description

 @param title title description
 @param cancelButtonTitle cancelButtonTitle description
 @param contextView contextView description
 @return return value description
 */
- (UIView *) popViewTitle:(NSString *)title
        cancelButtonTitle:(NSString *)cancelButtonTitle
              contextView:(__kindof UIView *)contextView{
    UIView *popview = [[UIView alloc] initWithFrame:self.frame];
    CGFloat viewHight = self.styel.topMargins;
    CGRect frame = CGRectZero;
    if (title != nil) {
        UILabel *titlelab = [[UILabel alloc] init];
        viewHight += CGRectGetHeight(titlelab.frame);
        viewHight += self.styel.spacing;
    }
    if (contextView != nil) {
        self.contextView = contextView;
        frame = contextView.frame;
        frame.origin.y = viewHight;
        contextView.frame = frame;
        viewHight += CGRectGetHeight(self.contextView.frame);
        viewHight += self.styel.spacing;
        [popview addSubview:contextView];
    }
    UIButton *cancelBtn = [self cancelBtnByTitle:cancelButtonTitle];
    [popview addSubview:cancelBtn];
    frame = cancelBtn.frame;
    frame.origin.y = viewHight;
    cancelBtn.frame = frame;
    viewHight += CGRectGetHeight(cancelBtn.frame);
    viewHight += self.styel.bottomMargins;

    frame = popview.frame;
    frame.size.height = viewHight;
    popview.frame = frame;
    return popview;
}
/**
 Description

 @return return value description
 */
- (id) init {
    if (self = [super init]) {

    }
    return self;
}

/**
 初始化

 @param style 样式
 @return return value description
 */
- (id) initWithStyle:(TGSheetViewStyle *)style{

    CGRect frame = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:frame]) {
        if (!style) {
            self.styel = [[TGSheetViewStyle alloc] init];
        }
        else {
            self.styel = style;
        }
        self.backgroundColor = self.styel.maskBackgrouColor;
        self.touchWinDissm = false;
    }
    return self;
}
/**
 初始化

 @param style 样式
 @param title 标题
 @param cancelButtonTitle 取消按钮
 @param contextView view
 @return return value description
 */
- (id) initWithStyle:(TGSheetViewStyle *)style
               Title:(NSString *)title
   cancelButtonTitle:(NSString *)cancelButtonTitle
         contextView:(__kindof UIView *)contextView{
    if (self = [self initWithStyle:style]) {
        UIView *popView = [self popViewTitle:title cancelButtonTitle:cancelButtonTitle contextView:contextView];
        self.popview = popView;
    }
    return self;
}
/**
 初始化

 @param style 样式
 @param title 标题
 @param cancelButtonTitle 取消按钮
 @param otherButtons 其他按钮array
 @param block block
 @return return value description
 */
- (id) initWithStyle:(TGSheetViewStyle *)style
               Title:(NSString *)title
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSArray *)otherButtons
    actionSheetBlock:(TGSheetViewSelectBlock)block{
    if (self = [self initWithStyle:style Title:title cancelButtonTitle:cancelButtonTitle contextView:nil]) {
        [self.contextArray addObjectsFromArray:otherButtons];
        UITableView *tableView = [self contextTableView];
        self.popview = [self popViewTitle:title cancelButtonTitle:cancelButtonTitle contextView:tableView];
        if (block) {
            self.block = block;
        }

    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark - UITableView
/**
 Description

 @param tableView tableView description
 @param section section description
 @return return value description
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contextArray.count;
}
/**
 Description

 @param tableView tableView description
 @return return value description
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/**
 Description

 @param tableView tableView description
 @param section section description
 @return return value description
 */
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
/**
 Description

 @param tableView tableView description
 @param section section description
 @return return value description
 */
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
/**
 Description

 @param tableView tableView description
 @param indexPath indexPath description
 @return return value description
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.styel.rowHegiht;
}

/**
 Description

 @param tableView tableView description
 @param section section description
 @return return value description
 */
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
/**
 Description

 @param tableView tableView description
 @param section section description
 @return return value description
 */
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
/**
 Description

 @param tableView tableView description
 @param indexPath indexPath description
 @return return value description
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TGSHEETVIEWTABLEVIEWCELL"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), self.styel.rowHegiht)];
    lab.font = self.styel.btnTitleFont;
    lab.textColor = self.styel.btnTitleColor;
    lab.text = self.contextArray[indexPath.row];
    lab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lab];
    return cell;

}
/**
 Description

 @param tableView tableView description
 @param indexPath indexPath description
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(indexPath.row);
    }
    [self dissm];
}

@end
