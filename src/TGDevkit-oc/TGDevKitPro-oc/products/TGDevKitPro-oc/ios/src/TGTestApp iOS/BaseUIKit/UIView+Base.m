//
//  UIView+Base.m
//  TGTestApp iOS
//
//  Created by toad on 2022/07/25.
//

#import "UIView+Base.h"
#import <objc/runtime.h>

NSString const *TGUIKey_AppUrl = @"TGUIKey_AppUrl";

@implementation UIResponder (TGDesignable)

- (void)setAppurl:(NSString *)appurl{
    
    objc_setAssociatedObject(self, &TGUIKey_AppUrl, appurl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)appurl{
    return objc_getAssociatedObject(self, &TGUIKey_AppUrl);
}

@end


@implementation UIView (Base)

/// 背景颜色
+ (UIColor *) baseBackcolor{
    return [UIColor colorNamed:@"COLOR_BACKCOLOR"];
}

/// 背景颜色
- (void) setBaseBackcolor{
    self.backgroundColor = [[self class] baseBackcolor];
}

@end


IBInspectable

