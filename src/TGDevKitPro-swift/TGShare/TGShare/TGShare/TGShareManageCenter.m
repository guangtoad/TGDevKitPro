//
//  TGShareManageCenter.m
//  TGSahre
//
//  Created by home on 2018/4/14.
//  Copyright © 2018年 toad. All rights reserved.
//

#import "TGShareManageCenter.h"

#pragma mark - QQ
@interface TGShareManageCenter (TencentOpenAPI)<QQApiInterfaceDelegate>
@property (nonatomic,strong) NSString *qqToken;
@end
@implementation TGShareManageCenter(TencentOpenAPI)

@dynamic qqToken;

- (BOOL) qqApiHandleOpenURL:(NSURL *) url{
    return [QQApiInterface handleOpenURL:url delegate:self];
}

- (void) qq:(NSString *)title description:(NSString *)description urlString:(NSString *)urlString image:(UIImage *)thumbImage {

}

- (BOOL) registerQQ{
    return false;
}
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{

}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp{

}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{

}


@end


#pragma mark - 微信

@interface TGShareManageCenter (WX)<WXApiDelegate>

@end

@implementation TGShareManageCenter(WX)

- (void) wx:(NSString *)title description:(NSString *)description urlString:(NSString *)urlString image:(UIImage *)thumbImage scene:(int)scene{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = @"";
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

- (BOOL) WXApiHandleOpenURL:(NSURL *) url{
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL) registerWX{
    [WXApi registerApp:@"wxd930ea5d5a258f4f" enableMTA:YES];

    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;

    [WXApi registerAppSupportContentFlag:typeFlag];
    return false;
}
/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req{

}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp{

}

@end

#pragma mark - 微博


#import "WeiboSDK.h"
#import "WBHttpRequest.h"

@interface TGShareManageCenter (Weibo)<WeiboSDKDelegate,WBHttpRequestDelegate>

@end

@implementation TGShareManageCenter(Weibo)

- (BOOL)weiboHandleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void) weibo:(NSString *)title description:(NSString *)description urlString:(NSString *)urlString image:(UIImage *)thumbImage {

    WBMessageObject *message = [WBMessageObject message];

    WBWebpageObject *webpage = [[WBWebpageObject alloc] init];
    webpage.objectID = @"identifier1";
    webpage.title = NSLocalizedString(@"分享网页标题", nil);
    webpage.description = description;
    NSData *imageData = UIImageJPEGRepresentation(thumbImage, 1);
    webpage.thumbnailData = imageData;
    webpage.webpageUrl = urlString;
    message.mediaObject = webpage;
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    //    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:myDelegate.wbtoken];
    //    [WeiboSDK sendRequest:message];

}

- (BOOL) registerWeibo{
    //    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    //    authRequest.redirectURI = kRedirectURI;
    //    authRequest.scope = @"all";
    //
    //    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:_messageObject authInfo:authRequest access_token:myDelegate.wbtoken];
    //    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
    //                         @"Other_Info_1": [NSNumber numberWithInt:123],
    //                         @"Other_Info_2": @[@"obj1", @"obj2"],
    //                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    if (![WeiboSDK sendRequest:request]) {
    //        [_indicatorView stopAnimating];
    //    }
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:SinaWeiBoAppKey];
    return false;
}
/**
 收到一个来自微博客户端程序的请求

 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{

}

/**
 收到一个来自微博客户端程序的响应

 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{

}

@end


//#import "AFNetworking.h"

@implementation TGShareManageCenter

- (id) init{
    if (self = [super init]) {

    }
    return self;
}

+ (TGShareManageCenter *) instance{
    static TGShareManageCenter *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[TGShareManageCenter alloc] init];
        }
    });
    return _instance;
}

- (void) registerSDK{
    [self registerWX];
    [self registerQQ];
    [self registerWeibo];
}

- (void) to:(TGShareToType)type
        url:(NSString *)urlStr
      title:(NSString *)title
    context:(NSString *)context
      image:(UIImage *)image{
    switch (type) {
        case ShareToTypeTencent:{
            [self qq:title description:context urlString:urlStr image:image];
            break;
        }
        case ShareTypeSinaWeibo:{
            [self weibo:title description:context urlString:urlStr image:image];
            break;
        }
        case ShareToTypeWXSceneSession:{
            [self wx:title description:context urlString:urlStr image:image scene:WXSceneSession];
            break;
        }
        case ShareToTypeWXSceneTimeline:{
            [self wx:title description:context urlString:urlStr image:image scene:WXSceneTimeline];
            break;
        }
        default:
            break;
    }
}

- (BOOL) handleOpenURL:(NSURL *)url delegate:(id)delegate{
    return [self WXApiHandleOpenURL:url] || [self weiboHandleOpenURL:url] || [self qqApiHandleOpenURL:url];

}

/**
 显示分享

 @return
 */
+ (BOOL) showShareView{
    return false;
}

@end
