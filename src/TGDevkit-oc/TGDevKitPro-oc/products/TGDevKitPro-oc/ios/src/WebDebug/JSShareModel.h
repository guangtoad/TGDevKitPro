//
//  JSShareModel.h
//  TGDevelopToolsApp
//
//  Created by toad on 2024/1/4.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSShareModel : NSObject

/// 标题
@property (nonatomic,strong) NSString *title;
/// 文言内容
@property (nonatomic,strong) NSString *contentText;
/// 分享图像Base64字符串
@property (nonatomic,strong) NSString *thumbData;
/// 分享的weburl
@property (nonatomic,strong) NSString *webpageUrl;
@property (nonatomic,strong) NSString *scene;

@end

NS_ASSUME_NONNULL_END
