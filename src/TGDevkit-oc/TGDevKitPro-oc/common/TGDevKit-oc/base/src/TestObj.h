//
//  TextObj.h
//  ObjCDome
//
//  Created by home on 2017/11/17.
//  Copyright © 2017年 toad. All rights reserved.
//

/**
 @brief #bdb06d
 
 使用场景
 @code
 小面积试用，用于特被需要强调和突出的文字 ／ 按钮和icon
 如确定按钮，和分类文字信息
 @endcode
 */

#define COLOR_ [UIColor colorwithHexString:@"#bdb06d"]//!< Deployモードの場合セットしない
#import <Foundation/Foundation.h>

@interface TextObj : NSObject
@property (nonatomic,strong) NSString *strtt;

- (void) textObj;

/**
 @brief tete
 @return sdfdd
 */
- (NSString *)tete;

@end
