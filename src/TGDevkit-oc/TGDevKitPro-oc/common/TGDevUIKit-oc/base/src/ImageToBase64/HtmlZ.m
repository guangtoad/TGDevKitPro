//
//  HtmlZ.m
//  HTMLIMAGE2BASE64
//
//  Created by home on 2017/12/25.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "HtmlZ.h"
#import <AppKit/AppKit.h>
@implementation HtmlZ

- (void)bbc{
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:@"Untitle.onecodego"];
    [panel setMessage:@"Choose the path to save the document"];
    [panel setAllowsOtherFileTypes:YES];
    [panel setAllowedFileTypes:@[@"onecodego"]];
    [panel setExtensionHidden:YES];
    [panel setCanCreateDirectories:YES];
//    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
//        if (result == NSFileHandlingPanelOKButton)
//        {
//            NSString *path = [[panel URL] path];
//            [@"onecodego" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        }
//    }];
//    NSMutableString *string = [[NSMutableString alloc] ]
}
@end
