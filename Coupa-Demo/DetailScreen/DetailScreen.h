//
//  DetailScreen.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailScreen : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) ImagesCategory *selectedCategory;

@end

NS_ASSUME_NONNULL_END
