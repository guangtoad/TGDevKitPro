//
//  TGBundleUtile.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGBundleUtil : NSBundle

+ (id) loadNibNamed:(NSString *)name owner:(nullable id)owner options:(nullable NSDictionary<UINibOptionsKey, id> *)options bundle:(NSBundle *)bundle index:(NSUInteger)index;

+ (id) loadNibNamed:(NSString *)name owner:(nullable id)owner options:(nullable NSDictionary<UINibOptionsKey, id> *)options;

+ (id) loadNibNamed:(NSString *)name owner:(nullable id)owner;

@end

NS_ASSUME_NONNULL_END
