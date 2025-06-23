//
//  UIView+Base.h
//  TGTestApp iOS
//
//  Created by toad on 2022/07/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


IB_DESIGNABLE

@interface UIResponder (TGDesignable)

@property (nonatomic, strong) IBInspectable NSString * _Nullable appurl;

@end

@interface UIView (Base)

/// 背景颜色
+ (UIColor *) baseBackcolor;

/// 背景颜色
- (void) setBaseBackcolor;

@end

NS_ASSUME_NONNULL_END

