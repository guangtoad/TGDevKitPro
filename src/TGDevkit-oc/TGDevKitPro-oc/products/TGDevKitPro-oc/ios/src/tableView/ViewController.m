//
//  ViewController.m
//  tableView
//
//  Created by toad on 2017/11/27.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UITableViewCell *cell;
@property (nonatomic,strong) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) UITableViewCell *selectCell;
@end

@implementation ViewController

//            NSData *imageData = nil;
//            NSString *mimeType = nil;
//
//            imageData = UIImagePNGRepresentation([(UIImageView *)view image]);
//
//            NSString *base64 = [imageData base64EncodedStringWithOptions:0];
////            printf("   base64:%s",[base64 UTF8String]);
//            NSData *newimageData = [[NSData alloc] initWithBase64EncodedString:base64  options:NSDataBase64DecodingIgnoreUnknownCharacters];
//            self.imageView.image = [UIImage imageWithData:newimageData];
//
////            NSFileManager *fileManager = [NSFileManager defaultManager];
////            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
////            NSString *filePath = [path stringByAppendingPathComponent:@"image1"];         //将图片存储到本地documents
////
////            NSError *error = nil;
////            [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
////            if (error != nil) {
////                NSLog(@"error:%@",error);
////            }
////            [fileManager createFileAtPath:[filePath stringByAppendingString:@"/image.png"] contents:newimageData attributes:nil];
////            NSLog(@"filePath:%@",[filePath stringByAppendingString:@"/image.png"]);
//        }
- (void) pView:(UIView *)pview vv:(NSString *)str{
    for (UIView *view in [pview subviews]) {
        NSString *ps = [NSString stringWithFormat:@"%@%@",str,NSStringFromClass([view class])];
        printf("\n%s",[ps UTF8String]);
        
        if ([view isKindOfClass:[UIView class]]) {
            [self pView:view vv:[NSString stringWithFormat:@"%@%@%@",str,NSStringFromClass([view class]),str]];
        }
    }
}
- (IBAction) btn_click:(id)sender{
    
    NSLog(@"self.cell:%@",self.cell);
    NSLog(@"self.cell.accessoryView:%@",self.cell.accessoryView);
    printf("\n\n");
    [self pView:self.cell vv:@"----"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.cell == nil) {
            self.cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
            self.cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        }
        return self.cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
        cell.textLabel.text = [NSString stringWithFormat:@"row:%ld",indexPath.row];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"箭头"]];
        UIView *aView = [[UIView alloc] initWithFrame:imageView.frame];
        [aView addSubview:imageView];
        cell.accessoryView = aView;
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectCell.accessoryView.transform =  CGAffineTransformMakeRotation(0 *M_PI / 180.0);
    CGRect frame = self.selectCell.accessoryView.frame;
    self.selectCell.accessoryView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.height, frame.size.width);
    if (self.selectCell != nil) {
        for (id obj in [self.selectCell subviews]) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)obj;
                button.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            }
        }
    }
    self.selectCell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"view:%@",cell.accessoryView);
    [self pView:self.selectCell vv:@"---"];
    self.selectCell.accessoryView.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
    for (id obj in [self.selectCell subviews]) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            button.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            NSLog(@"button:%@",NSStringFromCGRect(button.frame));
            NSLog(@"imageView:%@",NSStringFromCGRect(button.imageView.frame));
            UIImageView *imageview = [[button subviews] lastObject];
            NSLog(@"[button currentImage]:%@",[button currentImage]);
            
            NSLog(@"image:%@",imageview.image);
            NSLog(@"imageview:%@",imageview);
        }
    }
}

@end
