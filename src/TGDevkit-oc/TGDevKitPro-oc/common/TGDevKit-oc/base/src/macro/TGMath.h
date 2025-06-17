//
//  TGMath.h
//  smartGLink_cn
//
//  Created by toad on 2018/5/3.
//  Copyright © 2018年 toad. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TGNSLog(...) NSLog(__VA_ARGS__)
#else
#define TGNSLog(...){}
#endif
/**
 像素转换
 @code
 px / (CGFloat)[UIScreen mainScreen].scale
 @endcode
 @param px 像素
 @return pt
 */
//NS_INLINE CGFloat px2pt(CGFloat px) {
//    return px / (CGFloat)[UIScreen mainScreen].scale;
//}
//NS_INLINE CGFloat px2widhtpt(CGFloat px, CGFloat width){
//    return [UIScreen mainScreen].bounds.size.width / px2pt(width) * px2pt(px);
//}
//NS_INLINE CGFloat px10802pt(CGFloat px) {
//    return px2widhtpt(px, 1080.0f);
//}
//NS_INLINE CGFloat px750pt(CGFloat px) {
//    return px2widhtpt(px, 750.0f);
//}
//
