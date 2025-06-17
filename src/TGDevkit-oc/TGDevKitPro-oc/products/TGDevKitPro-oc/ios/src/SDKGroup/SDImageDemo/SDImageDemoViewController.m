//
//  SDImageDemoViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2023/10/18.
//

#import "SDImageDemoViewController.h"
#import <SDWebImage/SDWebImage.h>
@interface SDImageDemoViewController ()

@property (nonatomic,strong) IBOutlet UIImageView *img;
@end

@implementation SDImageDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction) click:(id)sender{
    NSURL *url = [NSURL URLWithString:@""];
    [self.img sd_setImageWithURL:url placeholderImage:[self.img image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
