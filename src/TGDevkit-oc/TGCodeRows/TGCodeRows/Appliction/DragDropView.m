//
//  DragDropView.m
//  TGCodeRows
//
//  Created by toad on 2022/05/07.
//

#import "DragDropView.h"

@implementation DragDropView

- (void) awakeFromNib{
    [super awakeFromNib];
    [self registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
}
- (void) dealloc{
    [self unregisterDraggedTypes];
}

- (id) initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        [self registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
    }
    return self;
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender{
    NSPasteboard *pboard = [sender draggingPasteboard];
    // 过滤掉非法的数据类型 <-> Filter out illegal data types
    if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}
- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender{
    NSPasteboard *pboard = [sender draggingPasteboard];
    // 过滤掉非法的数据类型 <-> Filter out illegal data types
    if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}
- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender{
    
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    NSMutableArray *fileList = [[NSMutableArray alloc] init];
    
    for (NSPasteboardItem *pasteboardItem in pasteboard.pasteboardItems) {
        NSString *string = [pasteboardItem stringForType:NSPasteboardTypeFileURL];
        NSURL *url = [NSURL URLWithString:string];
        if ([url isFileURL]) {
            [fileList addObject:[url path]];
        }
    }
    if (self.dragDropDelegate && [self.dragDropDelegate respondsToSelector:@selector(dragDropFilePathList:)]) {
        [self.dragDropDelegate dragDropFilePathList:fileList];
    }
    return YES;
}
- (void)draggingEnded:(id<NSDraggingInfo>)sender{
    
}

@end
