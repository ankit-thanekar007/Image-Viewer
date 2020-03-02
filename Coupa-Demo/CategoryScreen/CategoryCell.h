//
//  CategoryCell.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingImageView.h"
#import "ImagesCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCell : UITableViewCell

@property (nonatomic) IBOutlet LoadingImageView *image_1;
@property (nonatomic) IBOutlet LoadingImageView *image_2;
@property (nonatomic) IBOutlet LoadingImageView *image_3;
@property (nonatomic) IBOutlet LoadingImageView *image_4;

@property (nonatomic) IBOutlet UILabel *category;

-(void)setCellData:(ImagesCategory*)category;

@end

NS_ASSUME_NONNULL_END
