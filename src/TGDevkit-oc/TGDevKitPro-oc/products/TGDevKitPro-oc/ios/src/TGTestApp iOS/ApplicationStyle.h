//
//  ApplicationStyle.h
//  TGTestApp iOS
//
//  Created by toad on 2022/09/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// APP 样式
@interface ApplicationStyle : NSObject

/// 用户界面样式
@property (nonatomic,assign) UIUserInterfaceStyle interfaceStyle;
/// 默认背景颜色
@property (nonatomic,strong) UIColor *defaultBackgroupColor;
/// 默认文字颜色
@property (nonatomic,strong) UIColor *defaultTextColor;
/// 按钮默认颜色
@property (nonatomic,strong) UIColor *defaultMenuColor;
/// 按钮默认常态颜色
@property (nonatomic,strong) UIColor *defaultMenuNormalColor;
/// 按钮默认高亮颜色
@property (nonatomic,strong) UIColor *defaultMenuHighlightedColor;
/// 按钮默认关闭颜色
@property (nonatomic,strong) UIColor *defaultMenuDisabledColor;
/// 按钮默认选中颜色
@property (nonatomic,strong) UIColor *defaultMenuSelectedColor;
/// 文字默认常态颜色
@property (nonatomic,strong) UIColor *defaultTextNormalColor;
/// 文字默认高亮颜色
@property (nonatomic,strong) UIColor *defaultTextHighlightedColor;
/// 文字默认关闭颜色
@property (nonatomic,strong) UIColor *defaultTextDisabledColor;
/// 文字默认选中颜色
@property (nonatomic,strong) UIColor *defaultTextSelectedColor;

@end

NS_ASSUME_NONNULL_END
