//
//  ControlHeader.h
//  smartGLink_cn
//
//  Created by toad on 2017/11/21.
//  Copyright © 2017年 TechnoASKA. All rights reserved.
//

#ifndef ControlHeader_h
#define ControlHeader_h

//#import "Utility.h"
//#import "UIColor+Ext.h"
#import "RACMacros.h"


#define auto_delloc(__value) \
if (__value != nil) {\
[__value release]; \
__value = nil;}\

#define VALUENAME(__value) #__value
#define XMLPOT(__value) [NSString stringWithFormat:@"<%@>%@</%@>",@VALUENAME(__value),__value,@VALUENAME(__value)]

#define KEY_VALUE(__KEY,_VALUE) __KEY:_VALUE

#define CELL_KEY_KEY    @"key"
#define CELL_KEY_IDENTIFIER @"CellIdentifier"
#define CELL_KEY_TITLE  @"title"
#define CELL_KEY_IMAGE  @"image"
#define CELL_KEY_DETAIL @"detailKey"
#define CELL_KEY_ACCESSORY  @"CellAccessory"
#define CELL_KEY_VIEW   @"view"
#define CELL_KEY_SELECTIONSTYLE @"selectionStyle"

#define CELLIDENTIFIER(__CellIdentifier) KEY_VALUE(CELL_KEY_IDENTIFIER,__CellIdentifier)
#define CELLKEY(__key) KEY_VALUE(CELL_KEY_KEY,__key)
#define CELLTITLE(__title) KEY_VALUE(CELL_KEY_TITLE,__title)
#define CELLIMAGE(__image) KEY_VALUE(CELL_KEY_IMAGE,__image)
#define CELLACCESSORY(__CellAccessory) KEY_VALUE(CELL_KEY_ACCESSORY,__CellAccessory)
#define CELLDETAILKEY(__detailKey) KEY_VALUE(CELL_KEY_DETAIL,__detailKey)
#define CELLVIEW(__view) KEY_VALUE(CELL_KEY_VIEW,__view)
#define CELLSELECTIONSTYLE(__selectionStyle) KEY_VALUE(CELL_KEY_SELECTIONSTYLE,__selectionStyle)

#define CELL_IDENTIFIER_MSG         @"CELL_IDENTIFIER_MSG"
#define CELL_IDENTIFIER_EDITTET     @"CELL_IDENTIFIER_EDITTET"
#define CELL_IDENTIFIER_DEFAULE     @"CELL_IDENTIFIER_DEFAULE"

#define long2Str(__long) [NSString stringWithFormat:@"%ld",(long)__long]

#pragma mark -- PXToPt

NS_INLINE CGFloat px2pt(CGFloat px) {
    return px / [UIScreen mainScreen].scale;
}

NS_INLINE CGFloat px10802pt(CGFloat px) {
    return [UIScreen mainScreen].bounds.size.width / px2pt(1080.0f) * px2pt(px);
}


#endif /* ControlHeader_h */
