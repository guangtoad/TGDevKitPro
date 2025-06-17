//
//  WebDevelopToolController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import "DataSourceTableViewController.h"
//#import "TGDevelopToolsUIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebDevelopToolController : DataSourceTableViewController

@property (nonatomic,weak) IBOutlet TGDevelopTextField *txtUrl;
@property (nonatomic,strong) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
