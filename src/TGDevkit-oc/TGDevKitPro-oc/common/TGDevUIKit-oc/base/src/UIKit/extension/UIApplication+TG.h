//
//  UIApplication+TG.h
//  TGObjC
//
//  Created by toad on 2022/07/29.
//

#ifndef UIApplication_TG_h
#define UIApplication_TG_h
#import <UIKit/UIKit.h>

@interface UIApplication (TG)
@end


/**
 UIAppliction 扩展
 */
@interface UIApplication (TG_info)

/**
 获取app info
 
 @return info Dictionary
 */
+ (NSDictionary *) infoDictionary;
/**
 获取 app version
 
 @return app version
 */
+ (NSString *) shortVersion;
/**
 获取 app build version
 
 @return app build version
 */
+ (NSString *) buildVersion;
/**
 获取 app bundle id
 
 @return app bundle id
 */
+ (NSString *) bundleIdentifier;
/**
 获取app document 路径
 
 @return document 路径
 */
+ (NSString *) documentPath;

@end

/**
 应用信息
 */
@interface TGApplictionData : NSObject<NSCoding>
+ (id) unarchiveObjectWithFile:(NSString *)path API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) NS_REFINED_FOR_SWIFT;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSString *buildVersion;
@property (nonatomic,strong) NSString *bundleIdentifier;

@end
#endif /* UIApplication_TG_h */
