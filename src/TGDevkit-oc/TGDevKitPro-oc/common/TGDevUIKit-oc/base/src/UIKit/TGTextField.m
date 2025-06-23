//
//  TGTextField.m
//  TGObj
//
//  Created by toad on 15/9/17.
//  Copyright (c) 2015年 toad. All rights reserved.
//

#import "TGTextField.h"

@implementation TGTextField

- (void) setDelegate:(id<UITextFieldDelegate>)delegate{
    super.delegate = delegate;
}

- (void) dealloc{
    TGDealloc;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    [self addObserver:nil forKeyPath:nil options:NSKeyValueObservingOptionNew context:nil];
//    self removeObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#>
}
- (void) registerForKVO {

}

- (void) unregisterFromKVO {
//    for (NSString *keyPath in [self observableKeypaths]) {
//        [self removeObserver:self forKeyPath:keyPath];
//    }
}
@end
