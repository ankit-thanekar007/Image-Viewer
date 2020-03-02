//
//  DetailDataController.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagesCategory.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RefreshCell <NSObject>

-(void)refreshCellAtIndex:(int)index;

@end


@interface DetailDataController : NSObject

@property id delegate;

+ (instancetype)sharedInstance;

-(NSArray<ImageDetails*>*)getToBeUsed;
-(void)setMasterCategory : (ImagesCategory*)category;
-(void)replaceImageAtIndex : (int) row ;

@end

NS_ASSUME_NONNULL_END
