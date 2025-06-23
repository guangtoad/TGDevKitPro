//
//  ViewController+Base.m
//  TGDevelopToolsApp
//
//  Created by toad on 2023/12/27.
//

#import "UIViewController+TG.h"

@implementation UIViewController (Base)

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
}

- (void) showAlert:(NSString *)msg handler:(void (^ __nullable)(UIAlertAction *action))handler{
    [self showAlertTitle:@"提示" message:msg handler:handler];
}

@end


#import <objc/runtime.h>

NSString const *TGUIKey_DataSource = @"TGUIKey_DataSource";
NSString const *TGUIKey_IsDataLoaded = @"TGUIKey_IsDataLoaded";

@implementation UIViewController (DataSource)

- (void)setIsDataLoaded:(BOOL)isDataLoaded{
    objc_setAssociatedObject(self, &TGUIKey_IsDataLoaded, @(isDataLoaded), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isDataLoaded{
    return [objc_getAssociatedObject(self, &TGUIKey_IsDataLoaded) boolValue];
}
- (void)setDataSource:(NSMutableArray *)dataSource{
    objc_setAssociateTGdObject(self, &TGUIKey_DataSource, dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)dataSource{
    NSMutableArray * array = objc_getAssociatedObject(self, &TGUIKey_DataSource);
    if (NULL == array) {
        array = [[NSMutableArray alloc] init];
        [self setDataSource:array];
    }
    return array;
}

#pragma mark - Data Source
- (NSInteger ) dataNumber{
    return self.dataSource.count;
}
- (NSInteger ) dataNumberWithSection:(NSInteger)section{
    if (section < self.dataSource.count) {
        NSObject *object = [self.dataSource objectAtIndex:section];
        if (NULL == object) {
            return 0;
        }
        else if ([object isKindOfClass:[NSArray class]]) {
            return [(NSArray *)object count];
        }
        else {
            return 1;
        }
    }
    return 0;
}
- (NSArray *) objectsFormeDataSoureWithSection:(NSInteger)section{
    if (section < self.dataSource.count) {
        NSObject *obj = [self.dataSource objectAtIndex:section];
        if (NULL == obj) {
            return NULL;
        }
        else if ([obj isKindOfClass:[NSArray class]]) {
            return (NSArray *)obj;
        }
        else {
            return @[obj];
        }
    }
    else {
        return NULL;
    }
    return NULL;
}
- (NSObject *) objectFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSArray *objects = [self objectsFormeDataSoureWithSection:section];
    if (NULL == objects) {
        return NULL;
    }
    NSInteger row = indexPath.row;
    if (row < objects.count) {
        [objects objectAtIndex:row];
    }
    return NULL;
}
- (NSObject *) dictionaryFormeDataSoureWithIndexPath:(NSIndexPath *)indexPath{
    NSObject *object = [self objectFormeDataSoureWithIndexPath:indexPath];
    if (NULL != object) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            return object;
        }
        else if ([object isKindOfClass:[NSString class]]){
            return @{TGKEY_TITLE:object};
        }
        else {
            return @{TGKEY_INFO:object};
        }
    }
    return NULL;
}

@end

