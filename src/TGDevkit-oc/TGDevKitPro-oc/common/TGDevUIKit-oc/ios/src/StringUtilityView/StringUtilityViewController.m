//
//  StringUtilityViewController.m
//  TGHelperAPP
//
//  Created by toad on 2022/07/19.
//

#import "StringUtilityViewController.h"

@implementation StringUtilityViewController

- (NSString *) getInputStr{
    if (NULL != self.inputText) {
        return self.inputText.stringValue;
    }
    return @"";
}
- (IBAction)click_base64Encode:(id)sender{
    self.outputText.stringValue = [[self getInputStr] tg_base64Encode];
}
- (IBAction)click_base64DeCode:(id)sender{
    self.outputText.stringValue = [[self getInputStr] tg_base64Decode];
}
- (IBAction)click_uppercase:(id)sender{
    self.outputText.stringValue = [[self getInputStr] uppercaseString];
}
- (IBAction)click_lowercase:(id)sender{
    self.outputText.stringValue = [[self getInputStr] lowercaseString];
}
- (IBAction)click_urlencode:(id)sender{
    self.outputText.stringValue = [[self getInputStr] tg_urlEncode];
}
- (IBAction)click_urldecode:(id)sender{
    self.outputText.stringValue = [[self getInputStr] tg_urlDecode];
}
- (IBAction)click_md5:(id)sender{
    
}

@end
