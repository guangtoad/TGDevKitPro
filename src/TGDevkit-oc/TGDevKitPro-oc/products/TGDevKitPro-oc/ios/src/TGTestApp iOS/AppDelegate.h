//
//  AppDelegate.h
//  TGTestApp iOS
//
//  Created by toad on 2022/06/01.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DebugUtil.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong) UIWindow *windows;
@property (nonatomic,strong) UITabBarController *tabbarController;

//@property (readonly, strong) NSPersistentContainer *persistentContainer;

//- (void)saveContext;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

