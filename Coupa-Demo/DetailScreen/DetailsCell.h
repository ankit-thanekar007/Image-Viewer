//
//  DetailsCell.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingImageView.h"
#import "MetaDataView.h"
#import "ImageDetails.h"
#import "AsyncImageManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsCell : UICollectionViewCell

-(void)setCellData : (ImageDetails*)details atIndex : (int) row;

@property int indexOfCell;
@property(nonatomic) IBOutlet LoadingImageView *detailedImage;

@property(nonatomic) IBOutlet MetaDataView *likesView;
@property(nonatomic) IBOutlet MetaDataView *favoritesView;
@property(nonatomic) IBOutlet MetaDataView *viewsView;
@property(nonatomic) IBOutlet MetaDataView *downloadsView;

@end

NS_ASSUME_NONNULL_END
