//
//  Preferences.m
//  TGCodeRows
//
//  Created by toad on 2022/05/09.
//

#import "Preferences.h"

@interface Preferences ()<NSTextFieldDelegate,NSTokenFieldDelegate>

@property (weak) IBOutlet NSTextField *txtThreadCount;
@property (weak) IBOutlet NSSwitch *switchSpac;
@property (weak) IBOutlet NSSwitch *switchZS;
@property (weak) IBOutlet NSTokenField *txtFileTypes;
@property (weak) IBOutlet NSTokenField *txtIgnoreFolders;
//@property (weak) IBOutlet NSSwitch

@end

@implementation Preferences

- (void) reloadView{
    APPConfig *config = [APPConfig getInstance];
    self.txtThreadCount.stringValue = [NSString stringWithFormat:@"%ld",config.threadCount];
    
    self.txtFileTypes.objectValue = config.checkFileTypes;
    self.txtIgnoreFolders.objectValue = config.ignoreFolders;
    self.switchSpac.state = config.ignoreBlanks ? NSControlStateValueOn : NSControlStateValueOff;
    self.switchZS.state = config.ignoreComment ? NSControlStateValueOn : NSControlStateValueOff;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtThreadCount.delegate = self;
    self.txtIgnoreFolders.delegate = self;
    self.txtThreadCount.delegate = self;
    [self reloadView];
    // Do view setup here.
}
- (void)controlTextDidEndEditing:(NSNotification *)obj{
    APPConfig *config = [APPConfig getInstance];
    config.threadCount = [self.txtThreadCount.stringValue integerValue];
    config.checkFileTypes = self.txtFileTypes.objectValue;
    config.ignoreFolders = self.txtIgnoreFolders.objectValue;
    [config save];
    [self reloadView];
}
- (IBAction) clickSwitch:(id)sender{
    APPConfig *config = [APPConfig getInstance];
    config.ignoreBlanks = NSControlStateValueOn == self.switchSpac.state;
    config.ignoreComment = NSControlStateValueOn == self.switchZS.state;
    [config save];
    [self reloadView];
}
@end
