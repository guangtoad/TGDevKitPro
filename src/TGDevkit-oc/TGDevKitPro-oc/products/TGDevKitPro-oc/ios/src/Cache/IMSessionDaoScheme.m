//
////
////  IMSessionDaoScheme.m
////  IMCode
////
////  Created by carbonzhao on 2022/6/10.
////
////
// 
//#import "IMSessionDaoScheme.h"
//#import "JsonKit.h"
//#import "NSExtentionSloter.h"
//#import "IMDataConfigTools.h"
// 
//#if __has_include(<Realm/Realm.h>)
// 
//@implementation RLMStringModel
// 
//@end
// 
//@interface IMSessionDaoScheme ()
//@property (nonatomic,strong) NSString *usersTable;
// 
//@property BOOL spcyInMainThread;
//@end
// 
//@implementation IMSessionDaoScheme
//#pragma mark - daoLayer
//+ (NSArray *)ignoredProperties
//{
//    return @[@"spcyInMainThread"];
//}
// 
// 
//+ (NSArray *)allKeys
//{
//    Class csName = [self class];
//    IMSessionDaoScheme *aj = [[csName alloc] init];
//    NSArray <RLMProperty *>*allKeys = [aj objectSchema].properties;
//    
//    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
//    [allKeys enumerateObjectsUsingBlock:^(RLMProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [list addObject:obj.name];
//    }];
//    return list;
//}
// 
// 
//- (NSMutableDictionary *)keysValues
//{
//    __weak typeof(self) this = self;
//    NSMutableDictionary *jic = [NSMutableDictionary dictionaryWithCapacity:0];
//    NSArray <RLMProperty *>*allKeys = [self objectSchema].properties;
//    [allKeys enumerateObjectsUsingBlock:^(RLMProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
//    {
//        NSString *key = [obj name];
//        NSString *vl = [this valueForKey:key];
//        
//        if (obj.type == RLMPropertyTypeArray)
//        {
//            NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
//            RLMArray *arr = (RLMArray *)vl;
//            for (NSInteger idx=0; idx<arr.count; idx++)
//            {
//                RLMObject *t = [arr objectAtIndex:idx];
//                
//                if ([obj.objectClassName isEqualToString:@"RLMStringModel"])
//                {
//                    NSString *value = [(RLMStringModel *)t strValue];
//                    [list addObject:value];
//                }
//                else
//                {
//                    //
//                }
//            }
//            [jic setValue:list forKey:key];
//        }
//        else
//        {
//            if (![key isEqualToString:@"usersTable"] && ![key isEqualToString:@"spcyInMainThread"])
//            {
//                [jic setValue:vl forKey:key];
//            }
//        }
//    }];
//    
//    return jic;
//}
// 
// 
//+ (NSMutableDictionary *)daoSchemePropertiesType
//{
//    Class csName = [self class];
//    IMSessionDaoScheme *ab = [[csName alloc] init];
//    NSMutableDictionary *jic = [NSMutableDictionary dictionaryWithCapacity:0];
//    NSArray <RLMProperty *>*allKeys = [ab objectSchema].properties;
//    [allKeys enumerateObjectsUsingBlock:^(RLMProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
//    {
//        NSString *key = [obj name];
//        RLMPropertyType type = [obj type];
//        [jic setValue:intToStr(type) forKey:key];
//    }];
//    
//    return jic;
//}
// 
// 
////增、改
//- (void)save2Dao
//{
//    NSString *accid = [IMDataConfigTools instance].imAccountBlock();
//    
//    __weak typeof(self) ptr = self;
////    NSString *pkey = [[self class] primaryKey];
////    NSString *stext = [NSString stringWithFormat:@"usersTable='%@' AND %@='%@'",accid,pkey,[self valueForKey:pkey]];
//    NSArray <RLMProperty *>*allKeys = [self objectSchema].properties;
//    Class csName = NSClassFromString([[self objectSchema] className]);
//    IMSessionDaoScheme *ab = [[csName alloc] init];
//    NSDictionary *typeOj = [csName daoSchemePropertiesType];
//    [allKeys enumerateObjectsUsingBlock:^(RLMProperty * _Nonnull propers, NSUInteger idx, BOOL * _Nonnull stop)
//    {
//        NSString *key = [propers name];
////        NSLog(@"the key is %@",key);
//        NSString *vl = [ptr valueForKey:key];
//        RLMPropertyType type = (RLMPropertyType)[typeOj intForKey:key];
//        if (type == RLMPropertyTypeArray)
//        {
//            RLMArray *vlist = (RLMArray *)vl;
//            
//            RLMObject *obj = [vlist firstObject];
//            NSString *acsName = [[obj objectSchema] className];
//            RLMArray *nlist = [[RLMArray alloc] initWithObjectClassName:acsName];
//            for (NSInteger idx=0; idx<vlist.count; idx++)
//            {
//                RLMObject *obj = [vlist objectAtIndex:idx];
//                
//                NSArray <RLMProperty *>*allKeys = [obj objectSchema].properties;
//                
//                Class csName = NSClassFromString([[obj objectSchema] className]);
//                RLMObject *at = [[csName alloc] init];
//                
//                [allKeys enumerateObjectsUsingBlock:^(RLMProperty * _Nonnull xj, NSUInteger idx, BOOL * _Nonnull stop)
//                {
//                    NSString *key = [xj name];
//                    NSString *vl = [NSString stringWithFormat:@"%@",[obj valueForKey:key]];
//                    [at setValue:vl forKey:key];
//                }];
//                [nlist addObject:at];
//            }
//            
//            [ab setValue:nlist forKey:key];
//        }
//        else
//        {
//            if (type == RLMPropertyTypeInt || type == RLMPropertyTypeBool || type == RLMPropertyTypeFloat || type == RLMPropertyTypeDouble)
//            {
//                [ab setValue:vl forKey:key];
//            }
//            else
//            {
//                if ([vl isKindOfClass:[NSNumber class]])
//                {
//                    vl = [(NSNumber *)vl stringValue];
//                }
//                 
//                if (vl && ![vl isKindOfClass:[NSNull class]])
//                {
//                    [ab setValue:vl forKey:key];
//                }
//            }
//        }
//    }];
//    [ab setUsersTable:accid];
//    
//    RLMRealm * realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    [realm addOrUpdateObject:ab];
//    [realm commitWriteTransaction];
//}
// 
// 
//+ (void)save2Dao:(NSArray <IMSessionDaoScheme *>*)objs
//{
//    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
//    [list addObjectsFromArray:objs];
//    [list enumerateObjectsUsingBlock:^(IMSessionDaoScheme * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
//    {
//        [obj save2Dao];
//    }];
//}
// 
//- (void)updateOncePropertyValue:(void (^)(id thisModel))ablock
//{
//    ablock(self);
//    [self save2Dao];
//}
////删
//- (void)deleteFromDao
//{
//    if ([self isKindOfClass:[IMSessionDaoScheme class]])
//    {
//        [[self class] deleteFromDao:@[self]];
//    }
//    else
//    {
//        NSAssert(NO, @"instance error");
//    }
//}
// 
// 
//+ (void)deleteFromDao:(NSArray <IMSessionDaoScheme *>*)resArr
//{
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    NSString *accid = [IMDataConfigTools instance].imAccountBlock();
//    
//    [resArr enumerateObjectsUsingBlock:^(IMSessionDaoScheme * _Nonnull md, NSUInteger idx, BOOL * _Nonnull stop)
//    {
//        NSString *pkey = [[md class] primaryKey];
//        NSString *stext = [NSString stringWithFormat:@"usersTable='%@' AND %@='%@'",accid,pkey,[md valueForKey:pkey]];
//        Class csName = [md class];
//        RLMResults <IMSessionDaoScheme *>*resArr = [csName objectsWhere:stext];
//        
//        for (IMSessionDaoScheme *ab in resArr) {
//            [realm transactionWithBlock:^{
//                [realm deleteObject:ab];
//            }];
//        }
//    }];
//}
// 
//+ (void)deleteAll
//{
//    NSString *accid = [IMDataConfigTools instance].imAccountBlock();
//    
//    Class csName = [self class];
//    RLMResults <IMSessionDaoScheme *>*resArr = [csName objectsWhere:[NSString stringWithFormat:@"usersTable='%@'",accid]];
//    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    for (IMSessionDaoScheme *ab in resArr) {
//        [realm transactionWithBlock:^{
//            [realm deleteObject:ab];
//        }];
//    }
//}
// 
// 
// 
////查 ifAnd=yes,sql statement will be liked key=1 AND key1=2,other else key=1 OR key1=2....
//+ (NSArray <IMSessionDaoScheme *>*)queryFromDaoWithStatement:(NSDictionary *)stej ifAnd:(BOOL)ifAnd sortedKey:(NSString *)sortedKey
//{
//    NSString *accid = [IMDataConfigTools instance].imAccountBlock();
//    NSDictionary *typeOj = [self daoSchemePropertiesType];
//    __block NSString *whereSt = nil;
//    [stej enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop)
//    {
//        RLMPropertyType type = (RLMPropertyType)[typeOj intForKey:key];
//        if (!whereSt)
//        {
//            if (type == RLMPropertyTypeInt || type == RLMPropertyTypeBool || type == RLMPropertyTypeFloat || type == RLMPropertyTypeDouble)
//            {
//                whereSt = [NSString stringWithFormat:@"%@=%@",key,obj];
//            }
//            else
//            {
//                whereSt = [NSString stringWithFormat:@"%@='%@'",key,obj];
//            }
//        }
//        else
//        {
//            if (ifAnd)
//            {
//                if (type == RLMPropertyTypeInt || type == RLMPropertyTypeBool || type == RLMPropertyTypeFloat || type == RLMPropertyTypeDouble)
//                {
//                    whereSt = [whereSt stringByAppendingFormat:@" AND %@=%@",key,obj];
//                }
//                else
//                {
//                    whereSt = [whereSt stringByAppendingFormat:@" AND %@='%@'",key,obj];
//                }
//            }
//            else
//            {
//                if (type == RLMPropertyTypeInt || type == RLMPropertyTypeBool || type == RLMPropertyTypeFloat || type == RLMPropertyTypeDouble)
//                {
//                    whereSt = [whereSt stringByAppendingFormat:@" OR %@=%@",key,obj];
//                }
//                else
//                {
//                    whereSt = [whereSt stringByAppendingFormat:@" OR %@='%@'",key,obj];
//                }
//            }
//        }
//    }];
//    
//    if (whereSt)
//    {
//        whereSt = [whereSt stringByAppendingFormat:@" AND usersTable='%@'",accid];
//    }
//    else
//    {
//        whereSt = [NSString stringWithFormat:@"usersTable='%@'",accid];
//    }
//    Class csName = [self class];
//    RLMResults *resArr = [csName objectsWhere:whereSt];
//    if (sortedKey && sortedKey.length > 0)
//    {
//        NSMutableArray *dpList = [NSMutableArray arrayWithCapacity:0];
//        NSArray *sp = [sortedKey componentsSeparatedByString:@","];
//        if (sp.count == 1)
//        {
//            NSArray *spChild = [sortedKey componentsSeparatedByString:@" "];
//            NSString *key = [spChild firstObject];
//            NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//            key = [key stringByTrimmingCharactersInSet:set];
//            
//            NSString *vl = @"desc";
//            if (spChild.count > 1)
//            {
//                vl = [spChild lastObject];
//            }
//            
//            vl = [vl stringByTrimmingCharactersInSet:set];
//            BOOL ascending = [[vl lowercaseString] isEqualToString:@"asc"];
//            
//            RLMSortDescriptor *dp = [RLMSortDescriptor sortDescriptorWithKeyPath:key ascending:ascending];
//            
//            [dpList addObject:dp];
//        }
//        else
//        {
//            [sp enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop)
//            {
//                NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//                obj = [obj stringByTrimmingCharactersInSet:set];
//                
//                NSArray *spChild = [obj componentsSeparatedByString:@" "];
//                NSString *key = [spChild firstObject];
//                
//                key = [key stringByTrimmingCharactersInSet:set];
//                
//                NSString *vl = [spChild lastObject];
//                vl = [vl stringByTrimmingCharactersInSet:set];
//                BOOL ascending = [[vl lowercaseString] isEqualToString:@"asc"];
//                
//                RLMSortDescriptor *dp = [RLMSortDescriptor sortDescriptorWithKeyPath:key ascending:ascending];
//                
//                [dpList addObject:dp];
//            }];
//        }
//        
//        resArr = [resArr sortedResultsUsingDescriptors:dpList];
//    }
//    NSArray <NSString *>*allKeys = [self allProperties];
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
//    for (NSInteger idx=0; idx<resArr.count; idx++)
//    {
//        IMSessionDaoScheme *item = [resArr objectAtIndex:idx];
//        item.spcyInMainThread = [NSThread isMainThread];
//        
//        NSObject *at = [[csName alloc] init];
//        [allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSString *vl = [item valueForKeyPath:key];
//            RLMPropertyType type = (RLMPropertyType)[typeOj intForKey:key];
//            if (type == RLMPropertyTypeArray)
//            {
//                RLMArray *vlist = (RLMArray *)vl;
//                
//                RLMObject *obj = [vlist firstObject];
//                NSString *acsName = [[obj objectSchema] className];
//                RLMArray *nlist = [[RLMArray alloc] initWithObjectClassName:acsName];
//                for (NSInteger idx=0; idx<vlist.count; idx++)
//                {
//                    RLMObject *obj = [vlist objectAtIndex:idx];
//                    
//                    NSArray <RLMProperty *>*allKeys = [obj objectSchema].properties;
//                    
//                    Class csName = NSClassFromString([[obj objectSchema] className]);
//                    RLMObject *at = [[csName alloc] init];
//                    
//                    [allKeys enumerateObjectsUsingBlock:^(RLMProperty * _Nonnull xj, NSUInteger idx, BOOL * _Nonnull stop)
//                    {
//                        NSString *key = [xj name];
//                        NSString *vl = [NSString stringWithFormat:@"%@",[obj valueForKey:key]];
//                        [at setValue:vl forKey:key];
//                    }];
//                    [nlist addObject:at];
//                }
//                
//                [at setValue:nlist forKey:key];
//            }
//            else
//            {
//                if (type == RLMPropertyTypeInt || type == RLMPropertyTypeBool || type == RLMPropertyTypeFloat || type == RLMPropertyTypeDouble)
//                {
//                    [at setValue:vl forKey:key];
//                }
//                else
//                {
//                    if ([vl isKindOfClass:[NSNumber class]])
//                    {
//                        vl = [(NSNumber *)vl stringValue];
//                    }
//                     
//                    if (vl && ![vl isKindOfClass:[NSNull class]])
//                    {
//                        [at setValue:vl forKey:key];
//                    }
//                }
//            }
//        }];
//        [arr addObject:at];
//    }
//    return arr;
//}
// 
// 
// 
//+ (NSMutableArray <IMSessionDaoScheme *>*)queryFromDaoWithStatement:(NSDictionary *)stej
//{
//    BOOL flag = [stej allKeys].count>1?YES:NO;
//    return [self queryFromDaoWithStatement:stej ifAnd:flag sortedKey:nil];
//}
// 
// 
//+ (NSMutableArray <IMSessionDaoScheme *>*)queryFromDaoWithWhere:(NSString *)sttext
//{
//    NSString *accid = [IMDataConfigTools instance].imAccountBlock();
//    NSString *st = [NSString stringWithFormat:@"usersTable='%@'",accid];
//    if (sttext && sttext.length > 0)
//    {
//        st = [st stringByAppendingFormat:@" AND %@",sttext];
//    }
//    Class csName = [self class];
//    NSArray <NSString *>*allKeys = [self allProperties];
//    RLMResults <IMSessionDaoScheme *>*resArr = [csName objectsWhere:st];
//    NSDictionary *typeOj = [csName daoSchemePropertiesType];
//    
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
//    for (NSInteger idx=0; idx<resArr.count; idx++)
//    {
//        IMSessionDaoScheme *item = [resArr objectAtIndex:idx];
//        item.spcyInMainThread = [NSThread isMainThread];
//        
//        NSObject *at = [[csName alloc] init];
//        [allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSString *vl = [item valueForKeyPath:key];
//            RLMPropertyType type = (RLMPropertyType)[typeOj intForKey:key];
//            if (type == RLMPropertyTypeArray)
//            {
//                RLMArray *vlist = (RLMArray *)vl;
//                
//                RLMObject *obj = [vlist firstObject];
//                NSString *acsName = [[obj objectSchema] className];
//                RLMArray *nlist = [[RLMArray alloc] initWithObjectClassName:acsName];
//                for (NSInteger idx=0; idx<vlist.count; idx++)
//                {
//                    RLMObject *obj = [vlist objectAtIndex:idx];
//                    
//                    NSArray <RLMProperty *>*allKeys = [obj objectSchema].properties;
//                    
//                    Class csName = NSClassFromString([[obj objectSchema] className]);
//                    RLMObject *at = [[csName alloc] init];
//                    
//                    [allKeys enumerateObjectsUsingBlock:^(RLMProperty * _Nonnull xj, NSUInteger idx, BOOL * _Nonnull stop)
//                    {
//                        NSString *key = [xj name];
//                        NSString *vl = [NSString stringWithFormat:@"%@",[obj valueForKey:key]];
//                        [at setValue:vl forKey:key];
//                    }];
//                    [nlist addObject:at];
//                }
//                
//                [at setValue:nlist forKey:key];
//            }
//            else
//            {
//                if (type == RLMPropertyTypeInt || type == RLMPropertyTypeBool || type == RLMPropertyTypeFloat || type == RLMPropertyTypeDouble)
//                {
//                    [at setValue:vl forKey:key];
//                }
//                else
//                {
//                    if ([vl isKindOfClass:[NSNumber class]])
//                    {
//                        vl = [(NSNumber *)vl stringValue];
//                    }
//                     
//                    if (vl && ![vl isKindOfClass:[NSNull class]])
//                    {
//                        [at setValue:vl forKey:key];
//                    }
//                }
//            }
//        }];
//        [arr addObject:at];
//    }
//    return arr;
//}
// 
//+ (NSMutableArray <IMSessionDaoScheme *>*)queryAll
//{
//    return [self queryFromDaoWithWhere:nil];
//}
//@end
// 
//#endif
