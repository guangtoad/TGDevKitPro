//
//  AppDelegate.h
//  TGDevKitPro-oc
//
//  Created by toad on 2025/6/11.
//

#import <UIKit/UIKit.h>
@interface AppDelegate ()

@property (nonatomic,strong) UIWindow *win;
@property (nonatomic,assign) BOOL isLoaded;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@synthesize window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@end

