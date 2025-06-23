//
//  APPConfig.h
//  TGCodeRows
//
//  Created by toad on 2022/05/10.
//

#import <Foundation/Foundation.h>

extern NSString * _Nonnull const kPPRowsCheckFileTypes;
extern NSString * _Nonnull const kPPRowsIgnoreFolders;
extern NSString * _Nonnull const kEditCodes;
// The host process did enter the background
extern NSString * _Nonnull const kReloadSettingNotification;

NS_ASSUME_NONNULL_BEGIN


@interface APPConfig : NSObject

/// 统计文件类型
@property (nonatomic,strong) NSMutableArray * _Nonnull checkFileTypes;
/// 忽略检测的文件夹
@property (nonatomic,strong) NSMutableArray * _Nonnull ignoreFolders;
/// 需要忽略检测的文件夹
@property (nonatomic,strong) NSMutableArray * _Nonnull editCodes;
/// 线程数量
@property (nonatomic,assign) NSInteger threadCount;
/// 忽略空行
@property (nonatomic,assign) BOOL ignoreBlanks;
/// 忽略注释
@property (nonatomic,assign) BOOL ignoreComment;

/// 获取单例
+ (APPConfig *) getInstance;
- (BOOL) save;
@end

NS_ASSUME_NONNULL_END
