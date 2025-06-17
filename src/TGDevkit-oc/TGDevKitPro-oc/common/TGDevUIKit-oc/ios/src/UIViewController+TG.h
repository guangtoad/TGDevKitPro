//
//  ViewController+Base.h
//  TGDevelopToolsApp
//
//  Created by toad on 2023/12/27.
//

#import "TGKitPrefix.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Base)

@end

@interface UIViewController (Alert)

- (void) showAlert:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler;
- (void) showAlertTitle:(NSString *)title message:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler;
@end



@interface UIViewController (DataSource)

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) BOOL isDataLoaded;

#pragma mark - Data Source
- (NSInteger ) dataNumber;
- (NSInteger ) dataNumberWithSection:(NSInteger)section;
- (NSArray *) objectsFormeDataSoureWithSection:(NSInteger)section;
- (NSObject *) objectFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath;
- (NSObject *) dictionaryFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath;

@end


NS_ASSUME_NONNULL_END
