//
//  TGDragDropView.h
//  TGDiffHelp
//
//  Created by toad on 2022/06/24.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TGDragDropViewDelegate <NSObject>


- (BOOL)dragDropFilePathList:(NSArray<NSString *> *)filePathList;

@end

@interface TGDragDropView : NSView

@property (nonatomic, weak) IBOutlet id<TGDragDropViewDelegate> dragDropDelegate;
@property (nonatomic, strong) NSMutableArray *fileList;

@end

NS_ASSUME_NONNULL_END
