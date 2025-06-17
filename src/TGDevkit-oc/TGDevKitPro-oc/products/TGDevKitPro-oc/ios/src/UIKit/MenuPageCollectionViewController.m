//
//  MenuPageCollectionViewController.m
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/1.
//  _____  ____    _    _____
// |_   _|/ __ \  / \  |  __ \
//   | | | |  | |/ _ \ | |  | |
//   | | | |__| / ___ \| |__| |
//   |_|  \____/_/   \_\_____/

// 菜单集合视图


#import "MenuPageCollectionViewController.h"

/// 菜单集合视图
@interface MenuPageCollectionViewController ()

@end

/// 菜单集合视图
@implementation MenuPageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
/// 注册按钮视图
- (void) registerMenuItemView{
    if (NULL != self.tableView) {
        UINib *nib = [UINib nibWithNibName:@"MenuPageCollectionViewCell" bundle:NULL];
        [self.tableView registerNib:nib forCellReuseIdentifier:[MenuPageCollectionViewCell itemIdentifier]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self dataNumberWithSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
