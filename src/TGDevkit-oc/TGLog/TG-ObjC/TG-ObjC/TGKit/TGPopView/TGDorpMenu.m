//
//  TGDorpMenu.m
//  TGShare
//
//  Created by home on 2018/5/18.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGDorpMenu.h"

@implementation TGDorpMenuStyle

- (id) init{
    if (self = [super init]) {
        _menuColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];

        _menuSize = CGSizeMake(80, 100);
        _arrowHeight = 8;
        /** 圆角 */
        _cornerRadius = 10;
        /** row height */
        _rowHegiht = 32;
        /** 左边距 */
        _leftMargins = 15;
        /** 右边距 */
        _rightMargins = 15;
        /** 下边距 */
        _bottomMargins = 15;
        /** 上边距 */
        _topMargins = 8;
        _lenColor = [UIColor redColor];
        _titleColor = [UIColor whiteColor];
        _menuFont = [UIFont systemFontOfSize:12];
        _menuItemInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    }
    return self;
}

@end

const NSString *MenuItemKeyImageName = @"MenuItemKeyImageName";
const NSString *MenuItemKeyTitle = @"MenuItemKeyTitle";
#define TGDorpMenuCellReuseIdentifier @"TGDorpMenuCellReuseIdentifier"

@interface TGDorpMenuArrow ()
@property (nonatomic,strong) UIColor *color;
@end

@implementation TGDorpMenuArrow
- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
    }
    return self;
}
- (id) initWithFrame:(CGRect)frame color:(UIColor *)color{
    if (self = [self initWithFrame:frame]) {
        self.opaque = NO;
        if (color != nil) {
            self.color = color;
        }
        else {
            self.color = [UIColor greenColor];
        }
    }
    return self;
}
- (void) drawRect:(CGRect)rect{
    [super drawRect:rect];
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextClearRect(context, rect);//添加这句代码
    /*写文字*/
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextSetLineWidth(context, 0.01);
//    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
//    CGContextSetRGBStrokeColor(context,1, 0, 0, 1.0);
    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(CGRectGetMidX(rect), 0);//坐标1
    sPoints[1] =CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));//坐标2
    sPoints[2] =CGPointMake(0, CGRectGetMaxY(rect));//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}
@end

@interface TGDorpMenuCell : UITableViewCell
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel *title;
@end

@implementation TGDorpMenuCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        _title = [[UILabel alloc] init];;
        [self.contentView addSubview:_title];
        _image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
    }
    return self;
}

- (id) initWithStyle:(TGDorpMenuStyle *)style imageName:(NSString *)imageName title:(NSString *)title{
    if (self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TGDorpMenuCellReuseIdentifier]) {
    }
    return self;
}
- (void) setImage:(UIImage *)image title:(NSString *)title{
    [self.image setImage:image];
    [self.title setText:title];
}
- (void) setImageName:(NSString *)imageName title:(NSString *)title{
    [self.image setImage:[UIImage imageNamed:imageName]];
    [self.title setText:title];
}
- (void) resetWithStyle:(TGDorpMenuStyle *)style imageName:(NSString *)imageName title:(NSString *)title{
    CGRect frame = CGRectZero;
    frame.origin.x = [(TGDorpMenuStyle *)style menuItemInsets].left;
    frame.origin.y = [(TGDorpMenuStyle *)style menuItemInsets].top;
    frame.size.height = MAX([(TGDorpMenuStyle *)style rowHegiht] - [(TGDorpMenuStyle *)style menuItemInsets].top - [(TGDorpMenuStyle *)style menuItemInsets].bottom, 0);
    frame.size.width = [(TGDorpMenuStyle *)style menuSize].width;
    _title.font = [(TGDorpMenuStyle *)style menuFont];
    _title.textColor = [(TGDorpMenuStyle *)style titleColor];
    CGRect imageframe = frame;
    imageframe.size.width = imageframe.size.height;
    _image.frame = imageframe;

    CGRect titleframe = frame;
    titleframe.origin.x = CGRectGetMaxX(imageframe) + 4;
    titleframe.size.width = CGRectGetWidth(frame) - titleframe.origin.x;

    self.title.frame = titleframe;
    [self setImageName:imageName title:title];
}

@end
@interface TGDorpMenu()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong,readonly) NSArray<NSDictionary *> *dataArray;

@property (nonatomic,strong) TGDorpMenuArrow *arrow;
@property (nonatomic,strong) TGDorpMenuBlock block;
@end

@implementation TGDorpMenu

- (UIView *) popViewWith:(CGRect)frame{
    CGRect popFrame = CGRectZero;
    popFrame.size.width = MIN(CGRectGetWidth(self.frame) - [(TGDorpMenuStyle *)self.style leftMargins] - [(TGDorpMenuStyle *)self.style rightMargins], [(TGDorpMenuStyle *)self.style menuSize].width);
    popFrame.size.height = [(TGDorpMenuStyle *)self.style menuSize].height + [(TGDorpMenuStyle *)self.style arrowHeight];
    popFrame.origin.y = CGRectGetMaxY(frame) + [(TGDorpMenuStyle *)self.style topMargins];
    popFrame.origin.x = CGRectGetMidX(frame) - popFrame.size.width / 2.0;

    UIView *popView = [[UIView alloc] initWithFrame:popFrame];
    TGDorpMenuArrow *arrowView = [[TGDorpMenuArrow alloc] initWithFrame:CGRectMake(0, 0, [(TGDorpMenuStyle *)self.style arrowHeight], [(TGDorpMenuStyle *)self.style arrowHeight])color:[(TGDorpMenuStyle *)self.style menuColor]];
    //    arrowView.backgroundColor = [UIColor blueColor];
    arrowView.center = CGPointMake(popFrame.size.width / 2.0, arrowView.center.y);
    [popView addSubview:arrowView];

    CGFloat x_off = CGRectGetWidth(self.frame) - CGRectGetMaxX(popFrame);
    if (x_off < [(TGDorpMenuStyle *)self.style rightMargins]) {
        popFrame.origin.x -= [(TGDorpMenuStyle *)self.style rightMargins] - x_off;
        arrowView.center = CGPointMake(arrowView.center.x + ([(TGDorpMenuStyle *)self.style rightMargins] - x_off), arrowView.center.y);
    }
    CGFloat dataheight = _dataArray != nil ? _dataArray.count *  [(TGDorpMenuStyle *)self.style rowHegiht]: 0;
    CGRect table_frame = CGRectZero;
    table_frame.origin.x = 0;
    table_frame.origin.y = [(TGDorpMenuStyle *)self.style arrowHeight];
    table_frame.size.width = [(TGDorpMenuStyle *)self.style menuSize].width;
    table_frame.size.height = MIN(dataheight, [(TGDorpMenuStyle *)self.style menuSize].height);

    UITableView *table = [[UITableView alloc] initWithFrame:table_frame style:UITableViewStylePlain];
    [table registerClass:[TGDorpMenuCell class] forCellReuseIdentifier:TGDorpMenuCellReuseIdentifier];
    table.separatorColor = [(TGDorpMenuStyle *)self.style lenColor];
    table.layer.masksToBounds = true;
    table.layer.cornerRadius = [(TGDorpMenuStyle *)self.style cornerRadius];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [(TGDorpMenuStyle *)self.style menuColor];
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.001)];
    table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [table setBounces:false];

    [popView addSubview:table];
    [table reloadData];
    popView.frame = popFrame;

    return popView;
}

- (CGRect) getObjFrame:(__kindof NSObject *)obj{
    CGRect frame = CGRectZero;
    if ([obj isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)obj;
        frame = [view convertRect:view.bounds toView:nil];
    }
    else if ([obj isKindOfClass:[UIBarButtonItem class]]) {
        UIBarButtonItem *item = (UIBarButtonItem *)obj;
        UIView *_view = [item valueForKey:@"_view"];
        if (_view != nil) {
            frame = [_view convertRect:_view.bounds toView:nil];
        }
        else {

        }
    }
    else {

    }
    return frame;
}

- (id) init{
    TGDorpMenuStyle *style = [[TGDorpMenuStyle alloc] init];
    if (self = [self initWithStyle:style]) {

    }
    return self;
}

- (id) initWithStyle:(TGDorpMenuStyle *)style
              sender:(NSObject *)sender
           dataArray:(NSArray<NSDictionary *> *)dataArray
               block:(TGDorpMenuBlock)block{
    if (self = [self initWithStyle:style]) {
        if (dataArray != nil) {
            _dataArray = [[NSArray alloc] initWithArray:dataArray];
        }
        _block = block;
        CGRect frame = [self getObjFrame:sender];
        self.popview = [self popViewWith:frame];
    }
    return self;
}

- (id) initWithStyle:(TGDorpMenuStyle *)style sender:(NSObject *)sender{
    if (self = [self initWithStyle:style sender:sender dataArray:nil block:nil]) {
    }
    return self;
}
- (id) initWithSender:(NSObject *)sender dataArray:(NSArray<NSDictionary *> *)dataArray block:(TGDorpMenuBlock)block{
    TGDorpMenuStyle *style = [[TGDorpMenuStyle alloc] init];
    if (self = [self initWithStyle:style sender:sender dataArray:dataArray block:block]) {
    }
    return self;
}

- (id) initWithSender:(NSObject *)sender dataArray:(NSArray<NSDictionary *> *)dataArray{
    if (self = [self initWithSender:sender dataArray:dataArray block:nil]) {
    }
    return self;
}
- (id) initWithSender:(NSObject *)sender{
    if (self = [self initWithSender:sender dataArray:nil]) {
    }
    return self;
}

- (BOOL) show{
    self.popview.alpha = 0.01;
    self.backgroundColor = [UIColor clearColor];
    __weak typeof(self) weakSelf = self;
    return [self showAnimations:^{
        weakSelf.popview.alpha = 1;
    }];
}


- (void) dissm{
    __weak typeof(self) weakSelf = self;
    [super dissmAnimations:^{
        weakSelf.popview.alpha = 0.01;
    }];
}

#pragma mark - Action
- (BOOL) doSelectIndex:(NSInteger)index{
    BOOL ret = true;
    if (_block != nil) {
        _block(index);
    }
    [self dissm];
    return ret;
}
#pragma mark - UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [(TGDorpMenuStyle *)self.style rowHegiht];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray != nil ? 1 : 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArray.count;
    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TGDorpMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:TGDorpMenuCellReuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[TGDorpMenuCell alloc] initWithStyle:self.style imageName:dic[MenuItemKeyImageName]  title:dic[MenuItemKeyTitle]];
    }
    [cell resetWithStyle:self.style imageName:dic[MenuItemKeyImageName] title:dic[MenuItemKeyTitle]];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self doSelectIndex:indexPath.row];
    return;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
}

@end
