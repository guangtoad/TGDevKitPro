//
//  BaseImageView.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/5.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseImageView : UIImageView

- (void) setImageWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
