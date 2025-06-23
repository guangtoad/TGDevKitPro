//
//  DragDropView.h
//  TGCodeRows
//
//  Created by toad on 2022/05/07.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DragDropViewDelegate <NSObject>

- (BOOL)dragDropFilePathList:(NSArray<NSString *> *)filePathList;

@end

@interface DragDropView : NSSplitView

@property (nonatomic, weak) IBOutlet id<DragDropViewDelegate> dragDropDelegate;

@end

NS_ASSUME_NONNULL_END
