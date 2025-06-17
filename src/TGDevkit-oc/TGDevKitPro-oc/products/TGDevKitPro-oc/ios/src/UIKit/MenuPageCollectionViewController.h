//
//  MenuPageCollectionViewController.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/1.
//
// 菜单集合视图

#import <UIKit/UIKit.h>
#import "MenuPageViewController.h"
#import "MenuPageCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

/// 菜单集合视图
@interface MenuPageCollectionViewController : MenuPageViewController
@property (nonatomic,strong) IBOutlet UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
