//
//  AppDelegate.h
//  TGCodeRows
//
//  Created by toad on 2022/05/07.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end

