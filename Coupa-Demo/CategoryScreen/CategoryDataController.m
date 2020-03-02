//
//  CategoryDataController.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "CategoryDataController.h"
#import "NetworkWrapper.h"
#import "AppConstants.pch"
#import "RequestMap.h"

@interface CategoryDataController()

@property (nonatomic, retain) NSMutableArray <ImagesCategory*> *categoryMaster;

@end

@implementation CategoryDataController

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


-(void)fetchCategoryMasterData {
    
    RequestMap *map = [[RequestMap alloc]init];
    
    __block int counter = 0;
    
    dispatch_group_t group = dispatch_group_create();
    _categoryMaster = [NSMutableArray array];
    
    dispatch_group_enter(group);
//
    [map fetchNatureDataWithURL:@"&category=nature&per_page=20" and:^(BOOL result, ImagesCategory * _Nullable category) {
        if(result) {
            [self.categoryMaster addObject:category];
            counter++;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [map fetchScienceDataWithURL:@"&category=science&per_page=20" and:^(BOOL result, ImagesCategory * category) {
        if(result) {
            [self.categoryMaster addObject:category];
            counter++;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [map fetchEducationDataWithURL:@"&category=education&per_page=20" and:^(BOOL result, ImagesCategory * category) {
        if(result) {
            [self.categoryMaster addObject:category];
            counter++;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [map fetchFoodDataWithURL:@"&category=food&per_page=20" and:^(BOOL result, ImagesCategory * category) {
        if(result) {
            [self.categoryMaster addObject:category];
            counter++;
        }
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if(counter == 4) {
                [self.delegate addedDataToCategories:self.categoryMaster];
            }else {
                //TODO: 
                NSLog(@"Handle Error ?");
            }
        });
    });
}

@end
