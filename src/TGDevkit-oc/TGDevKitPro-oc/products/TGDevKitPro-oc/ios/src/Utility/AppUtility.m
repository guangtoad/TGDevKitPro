//
//  AppUtility.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/29.
//

#import "AppUtility.h"

@implementation AppUtility

+ (UIUserInterfaceStyle) userInterfaceStyle{
    
    return UIUserInterfaceStyleDark;
}

+ (void) setupAppearance{
    return;
    
    // 默认视图背景颜色
    UIColor *colorDefaultBackground = [UIColor colorNamed:@"COLOR_BACKCOLOR_DEFAULT"];
    // 按钮背景颜色
    UIColor *colorMenuBackground = [UIColor colorNamed:@"COLOR_BACKCOLOR_MENU"];
    // 文字颜色
    UIColor *colorDefaultTextColor = [UIColor colorNamed:@"COLOR_TEXT_DEFAULT"];
    
    UIColor *colorNormalTextColor = colorDefaultTextColor;
    UIColor *colorHighlightedTextColor = [UIColor colorNamed:@"COLOR_TEXT_DEFAULT"];
    UIColor *colorDisabledTextColor = [UIColor colorNamed:@"COLOR_TEXT_DEFAULT"];
    UIColor *colorSelectedTextColor = [UIColor colorNamed:@"COLOR_TEXT_DEFAULT"];
    
    NSDictionary<NSAttributedStringKey,id> *defaultTextAttributes = @{
        NSForegroundColorAttributeName:colorDefaultTextColor
    };
    
    UIWindow *windowAppearance = [UIWindow appearance];
    windowAppearance.backgroundColor = colorDefaultBackground;
    
    if (@available(iOS 13.0, *)) {
        windowAppearance.overrideUserInterfaceStyle = [self userInterfaceStyle];
    }
    else {
        
    }
    
    UIView *viewAppearance = [UIView appearance];
    if (@available(iOS 13.0, *)) {
        viewAppearance.overrideUserInterfaceStyle = [self userInterfaceStyle];
    }
    else {
    }
    viewAppearance.backgroundColor = colorDefaultBackground;
    
    UILabel *labelAppearance = [UILabel appearance];
    labelAppearance.textColor = colorDefaultTextColor;
    // UIButton 样式设置
    UIButton *button = [UIButton appearance];
    [button setTitleColor:colorNormalTextColor forState:UIControlStateNormal];
    [button setTitleColor:colorHighlightedTextColor forState:UIControlStateHighlighted];
    [button setTitleColor:colorDisabledTextColor forState:UIControlStateDisabled];
    [button setTitleColor:colorSelectedTextColor forState:UIControlStateSelected];
    button.backgroundColor = colorMenuBackground;
    button.titleLabel.textColor = colorDefaultTextColor;
    button.exclusiveTouch = true;
    [button setExclusiveTouch:YES];
    
    UITableViewCell *cell = [UITableViewCell appearance];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = colorDefaultTextColor;
    
    UITableView *tableView = [UITableView appearance];
    if (@available(iOS 15.0, *)) {
        tableView.sectionHeaderTopPadding = 0;
    } else {
        // Fallback on earlier versions
    }
    tableView.separatorInset  = UIEdgeInsetsZero;
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    [navigationBarAppearance.backItem setTitle:@"返回"];
    UITabBar *tabBarAppearance = [UITabBar appearance];
    tabBarAppearance.backgroundColor = colorMenuBackground;
    tabBarAppearance.tintColor = colorMenuBackground;
    tabBarAppearance.barTintColor = colorMenuBackground;
    
    UIBarItem *barItemAppearance = [UIBarItem appearance];
    [barItemAppearance setTitleTextAttributes:defaultTextAttributes forState:UIControlStateNormal];
    [barItemAppearance setTitleTextAttributes:defaultTextAttributes forState:UIControlStateHighlighted];
    [barItemAppearance setTitleTextAttributes:defaultTextAttributes forState:UIControlStateDisabled];
    [barItemAppearance setTitleTextAttributes:defaultTextAttributes forState:UIControlStateSelected];
    
    UITabBarItem *tabBarItemAppearance = [UITabBarItem appearance];
//    tabBarItemAppearance.backgroundColor = colorMenuBackground;
    
//    [tabBarItemAppearance setTitleTextAttributes:defaultTextAttributes forState:UIControlStateNormal];
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *standardTabBarAppearance = [UITabBarAppearance new];
        standardTabBarAppearance.backgroundColor = [UIColor whiteColor];
        standardTabBarAppearance.selectionIndicatorTintColor = [UIColor blackColor];
        tabBarAppearance.standardAppearance = standardTabBarAppearance;
        if (@available(iOS 15.0, *)) {
            tabBarAppearance.scrollEdgeAppearance = standardTabBarAppearance;
        }
        else {
        }
    } else {
        // Fallback on earlier versions
    }
}

@end
