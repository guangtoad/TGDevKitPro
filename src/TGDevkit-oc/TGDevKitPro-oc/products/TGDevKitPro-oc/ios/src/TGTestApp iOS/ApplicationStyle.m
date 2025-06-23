//
//  ApplicationStyle.m
//  TGTestApp iOS
//
//  Created by toad on 2022/09/27.
//

#import "ApplicationStyle.h"

/// APP 样式
@implementation ApplicationStyle

/// 默认背景颜色
- (UIColor *) defaultBackgroupColor{
    if (!_defaultBackgroupColor) {
        _defaultBackgroupColor = [UIColor colorNamed:@""];
    }
    else {
        // Do nothing
    }
    return _defaultBackgroupColor;
}
/// 默认文字颜色
- (UIColor *) defaultTextColor{
    if (!_defaultTextColor){
        _defaultTextColor = [UIColor colorNamed:@""];
    }
    return _defaultTextColor;
}
/// 按钮默认颜色
- (UIColor *) defaultMenuColor{
    if (!_defaultMenuColor) {
        _defaultMenuColor = [UIColor colorNamed:@""];
    }
    else {
        // Do nothing
    }
    return _defaultMenuColor;
}
/// 按钮默认常态颜色
- (UIColor *) defaultMenuNormalColor{
    if (!_defaultMenuNormalColor) {
        _defaultMenuNormalColor = [UIColor colorNamed:@""];
    }
    return NULL;
}
/// 按钮默认高亮颜色
- (UIColor *) defaultMenuHighlightedColor{
    return NULL;
}
/// 按钮默认关闭颜色
- (UIColor *) defaultMenuDisabledColor{
    return NULL;
}
/// 按钮默认选中颜色
- (UIColor *) defaultMenuSelectedColor{
    return NULL;
}
/// 文字默认常态颜色
- (UIColor *) defaultTextNormalColor{
    return NULL;
}
/// 文字默认高亮颜色
- (UIColor *) defaultTextHighlightedColor{
    return NULL;
}
/// 文字默认关闭颜色
- (UIColor *) defaultTextDisabledColor{
    return NULL;
}
/// 文字默认选中颜色
- (UIColor *) defaultTextSelectedColor{
    return NULL;
}

/// 根据设定获取颜色
/// @param lightColor 普通模式颜色
/// @param darkColor 深色模式颜色
+ (UIColor *) colorWithLight:(UIColor *)lightColor dark:(UIColor *)darkColor{
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (UIUserInterfaceStyleDark == traitCollection.userInterfaceStyle) {
                return darkColor;
            }
            else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}
/// 默认背景颜色
+ (UIColor *) defaultBackgroupColor{
    UIColor *color = [UIColor colorNamed:@""];
    return color;
}
/// 默认文字颜色
+ (UIColor *) defaultTextColor{
    UIColor *color = [UIColor colorNamed:@""];
    return color;
}
/// 按钮默认颜色
+ (UIColor *) defaultMenuColor{
    return NULL;
}
/// 按钮默认常态颜色
+ (UIColor *) defaultMenuNormalColor{
    return NULL;
}
/// 按钮默认高亮颜色
+ (UIColor *) defaultMenuHighlightedColor{
    return NULL;
}
/// 按钮默认关闭颜色
+ (UIColor *) defaultMenuDisabledColor{
    return NULL;
}
/// 按钮默认选中颜色
+ (UIColor *) defaultMenuSelectedColor{
    return NULL;
}
/// 文字默认常态颜色
+ (UIColor *) defaultTextNormalColor{
    return NULL;
}
/// 文字默认高亮颜色
+ (UIColor *) defaultTextHighlightedColor{
    return NULL;
}
/// 文字默认关闭颜色
+ (UIColor *) defaultTextDisabledColor{
    return NULL;
}
/// 文字默认选中颜色
+ (UIColor *) defaultTextSelectedColor{
    return NULL;
}

@end
