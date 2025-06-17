//
//  ScanKitFrameWorkViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2023/10/17.
//

#import "ScanKitFrameWorkViewController.h"

#import <ScanKitFrameWork/ScanKitFrameWork.h>
#import <AVFoundation/AVFoundation.h>
#import <UIView+Toast.h>
#import "HmsBitMapBuildViewController.h"
#import "CameraBitmapViewController.h"

@interface ScanKitFrameWorkViewController () <DefaultScanDelegate, CustomizedScanDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>{
    UILabel *versionLabel;//版本号
    HmsCustomScanViewController *hmsCustomScanViewController;
    NSString *timeSp1;
    int timestamp;
}

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIView *scanView;
@property (nonatomic, strong) UIImageView *scanAnimationView;

@end

@implementation ScanKitFrameWorkViewController{
    long sumTimestamp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self->sumTimestamp = 0;
    self.title = @"ScanKit";
//    [self.navigationController.navigationBar setBarTintColor:ColorRGB(55, 199, 190)];
    versionLabel = [[UILabel alloc] init];
    versionLabel.frame = CGRectMake(30, [[UIScreen mainScreen] bounds].size.height - 80, [[UIScreen mainScreen] bounds].size.width - 60, 30);
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
//    versionLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [self.view addSubview:versionLabel];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    versionLabel.text = [NSString stringWithFormat:@"版本号：%@", version];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated{

}

//Default View Mode
-(IBAction)buttonAction:(id)sender{
//    [Toast hide];
    NSTimeInterval t = [[NSDate date] timeIntervalSince1970]*1000;
    NSLog(@"start Default View: %f", t);
    
    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:FALSE];
    HmsDefaultScanViewController *hmsDefaultScanViewController = [[HmsDefaultScanViewController alloc] initDefaultScanWithFormatType:options];
    hmsDefaultScanViewController.defaultScanDelegate = self;
    //[self.view addSubview:hmsDefaultScanViewController.view];
    //[self addChildViewController:hmsDefaultScanViewController];
    //[self didMoveToParentViewController:hmsDefaultScanViewController];
    //self.navigationController.navigationBarHidden = YES;
    hmsDefaultScanViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:hmsDefaultScanViewController animated:YES completion:^{
    }];
    timeSp1 = [[self getNowTimeTimestamp] substringFromIndex:4];
}

//DefaultScan Delegate
- (void)defaultScanDelegateForDicResult:(NSDictionary *)resultDic{
    NSString *timeSp2 = [[self getNowTimeTimestamp] substringFromIndex:4];
    timestamp = [timeSp2 intValue] - [timeSp1 intValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self toastResult:resultDic];
    });
}

- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image{
    NSArray *list = [HmsBitMap multiDecodeBitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self toastResultForList:list];
    });
}

-(void)toastResult:(NSDictionary *)dic{
    [self.navigationController.view hideToastActivity];
    if (dic == nil){
        [self.view makeToast:@"Scanning code not recognized" duration:1.0 position:@"CSToastPositionCenter"];
        return;
    }
    NSString *string = [NSString stringWithFormat:@"%@", [dic objectForKey:@"text"]];
    if ([string length] == 0){
        [self.view makeToast:@"Scanning code not recognized" duration:1 position:@"CSToastPositionCenter"];
        return;
    }
    NSString *toastString = [NSString stringWithFormat:@"CostTime=%@ms; CodeFormat=%@; ResultType=%@; Result=%@", [dic objectForKey:@"time"], [dic objectForKey:@"formatValue"], [dic objectForKey:@"sceneType"], [dic objectForKey:@"text"]];
//    [Toast showSuccessWithMessage:toastString duration:3 finishHandler:^{
//        
//    }];
}

-(void)toastResultForList:(NSArray *)list{
    [self.navigationController.view hideToastActivity];
    if (list.count == 0){
        //[self.view makeToast:@"Scanning code not recognized" duration:1.0 position:@"CSToastPositionCenter"];
        return;
    }
    NSString *toastString = @"";
    for (int i=0; i<list.count; i++) {
        toastString = [NSString stringWithFormat:@"%@\n码图%d=====CodeFormat=%@; ResultType=%@; Result=%@\n", toastString, i+1, [[list objectAtIndex:i] objectForKey:@"formatValue"], [[list objectAtIndex:i] objectForKey:@"sceneType"], [[list objectAtIndex:i] objectForKey:@"text"]];
    }
//    [Toast showSuccessWithMessage:toastString duration:3 finishHandler:^{
//        
//    }];
}

//Customized View Mode
-(IBAction)buttonCustomizedAction:(id)sender{
//    [Toast hide];
    hmsCustomScanViewController = [[HmsCustomScanViewController alloc] init];
    hmsCustomScanViewController.customizedScanDelegate = self;
    hmsCustomScanViewController.backButtonHidden = false;
    hmsCustomScanViewController.continuouslyScan = true;
    hmsCustomScanViewController.cutArea = CGRectMake(41, ([[UIScreen mainScreen] bounds].size.height-([[UIScreen mainScreen] bounds].size.width-82))/2, [[UIScreen mainScreen] bounds].size.width-82, [[UIScreen mainScreen] bounds].size.width-82);
    [self.view addSubview:hmsCustomScanViewController.view];
    [self addChildViewController:hmsCustomScanViewController];
    [self didMoveToParentViewController:hmsCustomScanViewController];
    self.navigationController.navigationBarHidden = YES;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    UIButton *albumButton = [UIButton buttonWithType:0];
    albumButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-100, 10+statusBarFrame.size.height, 100, 40);
    [albumButton setTitle:@"Album" forState:UIControlStateNormal];
    [albumButton addTarget:self action:@selector(albumButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    // 标题Label的位置
    titleLabel.frame = CGRectMake(0, statusBarFrame.size.height+10, self.view.frame.size.width, 40);
    titleLabel.text = @"ScanKit";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    titleLabel.textColor = [UIColor whiteColor];
    [hmsCustomScanViewController.view.superview addSubview:titleLabel];
}

- (UIView *)scanView {
    if (!_scanView) {
        _scanView = [[UIView alloc] initWithFrame:CGRectMake(40, 50+24+38,
                                                             [[UIScreen mainScreen] bounds].size.width-80, [[UIScreen mainScreen] bounds].size.width-80)];
        _scanView.backgroundColor = [UIColor redColor];
        [_scanView addSubview:self.scanAnimationView];
    }
    return _scanView;
}

- (UIImageView *)scanAnimationView {
    if (!_scanAnimationView) {
         CGRect rect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 80, 38);
         _scanAnimationView = [[UIImageView alloc] initWithFrame:rect];
         _scanAnimationView.image = [UIImage imageNamed:@"cricle"];
        _scanAnimationView.layer.masksToBounds = YES;
    }
    return _scanAnimationView;
}

- (void)albumButtonAction:(id)sender{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    _imagePickerController.modalPresentationStyle = 0;
    [self presentViewController:_imagePickerController animated:YES completion:^{}];
}

- (void)scaneInitView:(UIView *)view{
    CALayer *topLayer = [[CALayer alloc] init];
    topLayer.frame = CGRectMake(0, -1, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height/2-([[UIScreen mainScreen] bounds].size.width-120)/2);
//    topLayer.backgroundColor = ColorRGBA(0, 0, 0, 0.5).CGColor;
    [view.layer addSublayer:topLayer];
    
    CALayer *rightLayer = [[CALayer alloc] init];
    rightLayer.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-60, [[UIScreen mainScreen] bounds].size.height/2-([[UIScreen mainScreen] bounds].size.width-120)/2-1, ([[UIScreen mainScreen] bounds].size.width-120)/2, [[UIScreen mainScreen] bounds].size.width-120);
//    rightLayer.backgroundColor = ColorRGBA(0, 0, 0, 0.5).CGColor;
    [view.layer addSublayer:rightLayer];
    
    CALayer *buttomLayer = [[CALayer alloc] init];
//    buttomLayer.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height/2+([[UIScreen mainScreen] bounds].size.width-120)/2-1, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-(((iosVersion()>=7.0) ? 65 : 45)+70+([[UIScreen mainScreen] bounds].size.width-120)-1)-84+120);
//    buttomLayer.backgroundColor = ColorRGBA(0, 0, 0, 0.5).CGColor;
    [view.layer addSublayer:buttomLayer];
    
    CALayer *leftLayer = [[CALayer alloc] init];
    leftLayer.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height/2-([[UIScreen mainScreen] bounds].size.width-120)/2-1, 60, ([[UIScreen mainScreen] bounds].size.width-120));
//    leftLayer.backgroundColor = ColorRGBA(0, 0, 0, 0.5).CGColor;
    [view.layer addSublayer:leftLayer];
    
    CALayer *scannerLayer = [[CALayer alloc] init];
    scannerLayer.frame = CGRectMake(60, [[UIScreen mainScreen] bounds].size.height/2-([[UIScreen mainScreen] bounds].size.width-120)/2, ([[UIScreen mainScreen] bounds].size.width-120), ([[UIScreen mainScreen] bounds].size.width-120));
    scannerLayer.backgroundColor = [UIColor clearColor].CGColor;
    [view.layer addSublayer:scannerLayer];
    
    UIFont *font = [UIFont systemFontOfSize:18];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    
    CATextLayer *left_textLayer= [CATextLayer layer];
    left_textLayer.frame =  CGRectMake(-9, -11, 20, 20);
    [scannerLayer addSublayer:left_textLayer];
//    left_textLayer.foregroundColor = ColorRGB(77, 149, 236).CGColor;
    left_textLayer.alignmentMode = kCAAlignmentLeft;
    left_textLayer.wrapped = YES;
    left_textLayer.font = fontRef;
    left_textLayer.fontSize = font.pointSize;
    left_textLayer.string = @"┌";
    left_textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    CATextLayer *right_textLayer= [CATextLayer layer];
    right_textLayer.frame =  CGRectMake(scannerLayer.frame.size.width-9, -11, 20, 20);
    [scannerLayer addSublayer:right_textLayer];
//    right_textLayer.foregroundColor = ColorRGB(77, 149, 236).CGColor;
    right_textLayer.alignmentMode = kCAAlignmentLeft;
    right_textLayer.wrapped = YES;
    right_textLayer.font = fontRef;
    right_textLayer.fontSize = font.pointSize;
    right_textLayer.string = @"┐";
    right_textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    CATextLayer *left_buttom_textLayer= [CATextLayer layer];
    left_buttom_textLayer.frame =  CGRectMake(-9, scannerLayer.frame.size.height-12, 20, 20);
    [scannerLayer addSublayer:left_buttom_textLayer];
//    left_buttom_textLayer.foregroundColor = ColorRGB(77, 149, 236).CGColor;
    left_buttom_textLayer.alignmentMode = kCAAlignmentLeft;
    left_buttom_textLayer.wrapped = YES;
    left_buttom_textLayer.font = fontRef;
    left_buttom_textLayer.fontSize = font.pointSize;
    left_buttom_textLayer.string = @"└";
    left_buttom_textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    CATextLayer *right_buttom_textLayer= [CATextLayer layer];
    right_buttom_textLayer.frame =  CGRectMake(scannerLayer.frame.size.width-9, scannerLayer.frame.size.height-12, 20, 20);
    [scannerLayer addSublayer:right_buttom_textLayer];
//    right_buttom_textLayer.foregroundColor = ColorRGB(77, 149, 236).CGColor;
    right_buttom_textLayer.alignmentMode = kCAAlignmentLeft;
    right_buttom_textLayer.wrapped = YES;
    right_buttom_textLayer.font = fontRef;
    right_buttom_textLayer.fontSize = font.pointSize;
    right_buttom_textLayer.string = @"┘";
    right_buttom_textLayer.contentsScale = [UIScreen mainScreen].scale;
}

//CustomizedScan Delegate
- (void)customizedScanDelegateForResult:(NSDictionary *)resultDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self toastResult:resultDic];
        //[self->hmsCustomScanViewController backAction];
        //hmsCustomScanViewController = nil;
    });
}

//BitMap View Mode
-(IBAction)bitMapAction:(id)sender{
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickersourceType:@"Camera"];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"Album" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickersourceType:@"Album"];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"Cancle" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:sheet animated:YES completion:nil];
}

//BitMapBuild View Mode
-(IBAction)bitMapBuildAction:(id)sender{
    HmsBitMapBuildViewController *hmsBitMapBuildViewController = [[HmsBitMapBuildViewController alloc] init];
    [self.navigationController pushViewController:hmsBitMapBuildViewController animated:YES];
}

#pragma mark - actionsheet delegate
-(void)imagePickersourceType:(NSString *)type{
    if ([type isEqualToString:@"Album"]){
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePickerController.modalPresentationStyle = 0;
        [self presentViewController:_imagePickerController animated:YES completion:^{}];
    }else{
        CameraBitmapViewController *cameraBitmapViewController = [[CameraBitmapViewController alloc] init];
        [self.navigationController pushViewController:cameraBitmapViewController animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSArray *list = [HmsBitMap multiDecodeBitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
    [self toastResultForList:list];
    [picker dismissViewControllerAnimated:YES completion:^{ }];
}

- (NSString *)getNowTimeTimestamp{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}
@end
