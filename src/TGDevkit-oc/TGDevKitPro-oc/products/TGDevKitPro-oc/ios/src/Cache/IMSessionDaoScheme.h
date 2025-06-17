////
////  IMSessionDaoScheme.h
////  IMCode
////
////  Created by carbonzhao on 2022/6/10.
////
////
// 
//#if __has_include(<Realm/Realm.h>)
//#import <Realm/Realm.h>
// 
//@interface RLMStringModel : RLMObject
//@property (copy,nonatomic) NSString *strValue;
//@end
// 
//RLM_ARRAY_TYPE(RLMStringModel)
// 
// 
///**根据REALM原则 ，数据查询在什么线程则在什么线程使用，跨线程使用查询出来的RLMObject及其他对象，均会崩溃。IMSessionDaoScheme实现解耦，所有查询出来的RLMObject进行二次对象替换，保证数据为非REALM托管的对象。*/
//@interface IMSessionDaoScheme : RLMObject
// 
////RLMObject实现已经阉割了OC的RUNTIME方法，无法通过class_copyPropertyList来获取其属性及值
//+ (NSArray <NSString *>*)allKeys;
//- (NSMutableDictionary *)keysValues;
////增、改
//- (void)save2Dao;
//+ (void)save2Dao:(NSArray <IMSessionDaoScheme *>*)resArr;
// 
////修改某个属性值
//- (void)updateOncePropertyValue:(void (^)(id thisModel))ablock;
// 
////删
//- (void)deleteFromDao;
//+ (void)deleteFromDao:(NSArray <IMSessionDaoScheme *>*)resArr;
//+ (void)deleteAll;
// 
//+ (NSMutableArray <IMSessionDaoScheme *>*)queryAll;
//+ (NSMutableArray <IMSessionDaoScheme *>*)queryFromDaoWithStatement:(NSDictionary *)stej;
//+ (NSMutableArray <IMSessionDaoScheme *>*)queryFromDaoWithWhere:(NSString *)sttext;
///**查 ifAnd=yes,sql statement will be liked key=1 AND key1=2,other else key=1 OR key1=2....,
// sortedKey can be key desc,key1 asc,use ',' seperator the statement
// */
//+ (NSMutableArray <IMSessionDaoScheme *>*)queryFromDaoWithStatement:(NSDictionary *)stej ifAnd:(BOOL)ifAnd sortedKey:(NSString *)sortedKey;
//@end
// 
//// This protocol enables typed collections. i.e.:
//// RLMArray<IMSessionDaoScheme *><IMSessionDaoScheme>
//RLM_ARRAY_TYPE(IMSessionDaoScheme)
// 
//#endif
