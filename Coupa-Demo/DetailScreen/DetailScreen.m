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
@property IBOutlet NSMutableArray<ImageDetails*> *imageDetailsArray;

@end

@implementation DetailScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DetailDataController sharedInstance] setMasterCategory:_selectedCategory];
    [[DetailDataController sharedInstance] setDelegate:self];
    
    _imageDetailsArray = [[[DetailDataController sharedInstance] getToBeUsed] mutableCopy];
    
    [self setupCollectionViewCell];
    [self setupRefreshControl];
}

-(void)setupCollectionViewCell {
    UINib *nib = [UINib nibWithNibName:@"DetailsCell" bundle:[NSBundle mainBundle]];
    
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"DetailsCell"];
}

-(void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    _collectionView.refreshControl = refreshControl;
    [_collectionView.refreshControl addTarget:self action:@selector(handleSingleImageRefresh) forControlEvents:UIControlEventValueChanged];
    [[_collectionView refreshControl] endRefreshing];
}

-(void)handleSingleImageRefresh {
    DetailsCell *cell = [[_collectionView visibleCells] firstObject];
    NSLog(@"Index Of Cell %d", [cell indexOfCell]);
    
    [[DetailDataController sharedInstance] replaceImageAtIndex:[cell indexOfCell]];
    
    [[_collectionView refreshControl] endRefreshing];
}

#pragma mark UICollectionView DataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DetailsCell *cell = (DetailsCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailsCell" forIndexPath:indexPath];
    [cell setCellData:_imageDetailsArray[indexPath.row] atIndex:(int)indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_imageDetailsArray count];
}

#pragma mark UICollectionView Delegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    return cellSize;
}

#pragma mark Refresh Cell Delegate

-(void)refreshCellAtIndex:(int)index {
    
    _imageDetailsArray = [[[DetailDataController sharedInstance] getToBeUsed]mutableCopy];
    [[self collectionView] reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index
                                                                         inSection:0]]];
}

@end
