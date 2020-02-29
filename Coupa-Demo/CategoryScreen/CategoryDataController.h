//
//  CategoryDataController.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDetails.h"
#import "ImagesCategory.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CategoryDataParsed <NSObject>
-(void)addedDataToCategories:(NSMutableArray<ImagesCategory*>*)values;
-(void)failedToFetchData:(NSError*)error;

@end

@interface CategoryDataController : NSObject

@property id delegate;

+ (instancetype)sharedInstance;
-(void)fetchCategoryMasterData;

@end

NS_ASSUME_NONNULL_END
