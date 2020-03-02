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

{
    BOOL didRefresh;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:_selectedCategory.title];
    [[DetailDataController sharedInstance] setMasterCategory:_selectedCategory];
    [[DetailDataController sharedInstance] setDelegate:self];
    
    _imageDetailsArray = [[DetailDataController sharedInstance] getToBeUsed];
    
    [self setupCollectionViewCell];
    [self setupRefreshControl];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_imageDetailsArray removeAllObjects];
    _imageDetailsArray = nil;
    _selectedCategory = nil;
    [[AsyncImageManager sharedInstance] clearCache];
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
    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
//    DetailsCell *cell = [[_collectionView visibleCells] firstObject];
    [[DetailDataController sharedInstance] replaceImageAtIndex:(int)visibleIndexPath.row];
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
    _imageDetailsArray = [[DetailDataController sharedInstance] getToBeUsed];
    [[self collectionView] reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index
                                                                         inSection:0]]];
    [[_collectionView refreshControl] endRefreshing];
}

-(void)failedToFetch:(int)index {
    [[_imageDetailsArray objectAtIndex:index] setShouldRetry:YES];
    [[self collectionView] reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index
                                                                         inSection:0]]];
    [[_collectionView refreshControl] endRefreshing];
}

@end
