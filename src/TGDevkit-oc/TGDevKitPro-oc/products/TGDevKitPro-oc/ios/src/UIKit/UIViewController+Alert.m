//
//  UIViewController+Alert.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/22.
//

#import "UIViewController+Alert.h"

@interface UIViewController (Alert)

@end

@implementation UIViewController (Alert)

- (void) performSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)wait withObjects:(id)Objects ,...{
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (!sig) return;
    NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
    [invo setTarget:self];
    [invo setSelector:selector];
    
    va_list arglist;//定义一个va_list指针变量，指向参数列表
    if(Objects)
    {
        int index = 2;
        [invo setArgument:&Objects atIndex:index++];
        va_start(arglist, Objects);
        NSString *Object = va_arg(arglist, id);
        while(Object)
        {
            [invo setArgument:&Object atIndex:index++];
            Object = va_arg(arglist, id);
        }
        va_end(arglist);//释放arglist指针，结束提取
    }
    [invo retainArguments];
    [invo performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

- (void) showAlertTitle:(NSString *)title message:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (NULL != handler) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
        [alert addAction:action];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
    [alert addAction:cancel];
    [self performSelectorOnMainThread:@selector(presentViewController:animated:completion:) waitUntilDone:true withObjects:alert,@(true),NULL];
    return;
    
//    [self presentViewController:alert animated:true completion:NULL];
//    if (![NSThread isMainThread]) {
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
//            if (NULL != handler) {
//                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
//                [alert addAction:action];
//            }
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
//            [alert addAction:cancel];
//            [self presentViewController:alert animated:true completion:NULL];
//        });
//    }
//    else {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
//        if (NULL != handler) {
//            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
//            [alert addAction:action];
//        }
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
//        [alert addAction:cancel];
//
//        [self presentViewController:alert animated:true completion:NULL];
//    }
}

- (void) showAlert:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler{
    [self showAlertTitle:@"提示" message:msg handler:handler];
}

@end
