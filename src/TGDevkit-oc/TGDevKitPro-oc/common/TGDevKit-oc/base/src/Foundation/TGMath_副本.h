//
//  TGMATH.h
//  TGObj
//
//  Created by toad on 15/9/21.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#ifndef TGObj_TGMATH_h
#define TGObj_TGMATH_h

#endif

#if __has_include(<CoreGraphics/CGGeometry.h>)
#include <CoreGraphics/CGGeometry.h>

CG_INLINE CGRect CGRectMakeWithSize(CGSize size)
{
    CGRect rect = CGRectZero;
    rect.size.width = size.width;
    rect.size.height = size.height;
    return rect;
}

#endif
