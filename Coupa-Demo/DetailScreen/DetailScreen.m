//
//  DetailScreen.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "DetailScreen.h"
#import "DetailsCell.h"

@interface DetailScreen ()
@property IBOutlet UICollectionView *collectionView;
@end

@implementation DetailScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionViewCell];
}

-(void)setupCollectionViewCell {
    UINib *nib = [UINib nibWithNibName:@"DetailsCell" bundle:[NSBundle mainBundle]];
    
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"DetailsCell"];
}

#pragma mark UICollectionView DataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DetailsCell *cell = (DetailsCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailsCell" forIndexPath:indexPath];
    [cell setCellData:_selectedCategory.imageMaster[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_selectedCategory.imageMaster count];
}

#pragma mark UICollectionView Delegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    return cellSize;
}

@end
