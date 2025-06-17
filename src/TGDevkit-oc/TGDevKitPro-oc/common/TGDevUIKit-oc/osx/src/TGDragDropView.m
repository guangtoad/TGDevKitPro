//
//  TGDragDropView.m
//  TGDiffHelp
//
//  Created by toad on 2022/06/24.
//

#import "TGDragDropView.h"


@implementation TGDragDropView


- (NSMutableArray *)fileList{
    if (!_fileList) {
        _fileList = [[NSMutableArray alloc] init];
    }
    return _fileList;
}

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
    if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender{
    NSPasteboard *pboard = [sender draggingPasteboard];
    if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender{
    
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    [self.fileList removeAllObjects];
    for (NSPasteboardItem *pasteboardItem in pasteboard.pasteboardItems) {
        NSString *string = [pasteboardItem stringForType:NSPasteboardTypeFileURL];
        NSURL *url = [NSURL URLWithString:string];
        if ([url isFileURL]) {
            [self.fileList addObject:[url path]];
        }
    }
    if (self.dragDropDelegate && [self.dragDropDelegate respondsToSelector:@selector(dragDropFilePathList:)]) {
        [self.dragDropDelegate dragDropFilePathList:self.fileList];
    }
    return YES;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender{
    
}

@end
