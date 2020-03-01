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

typedef enum : NSUInteger {
    NATURE,
    SCIENCE,
    EDUCATION,
    FOOD
} CATEGORIES;


@interface CategoryDataController()

@property (nonatomic) NSMutableArray <ImagesCategory*> *categoryMaster;

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
    dispatch_group_t group = dispatch_group_create();
    _categoryMaster = [NSMutableArray array];
    
    dispatch_group_enter(group);
    [self fetchNatureData:^(BOOL result) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self fetchScienceData:^(BOOL result) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self fetchEducationData:^(BOOL result) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self fetchFoodData:^(BOOL result) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^(void){
               [self.delegate addedDataToCategories:self.categoryMaster];
        });
    });
}


-(void)fetchNatureData : (void(^)(BOOL result))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=nature"];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:url
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *nature = [self parseImageData:data withCategory:NATURE];
            if(nature) {
                [self.categoryMaster addObject:nature];
                completion(YES);
            }else {
                completion(NO);
            }
        }else {
            [self->_delegate failedToFetchData:error];
            completion(NO);
        }
    }];
}

-(void)fetchScienceData : (void(^)(BOOL result))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=science"];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:url
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *science = [self parseImageData:data withCategory:SCIENCE];
            if(science) {
                [self.categoryMaster addObject:science];
                completion(YES);
            }else {
                completion(NO);
            }
        }else {
            [self->_delegate failedToFetchData:error];
            completion(NO);
        }
    }];
}

-(void)fetchEducationData : (void(^)(BOOL result))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=education"];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:url
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *education = [self parseImageData:data withCategory:EDUCATION];
            if(education) {
                [self.categoryMaster addObject:education];
                completion(YES);
            }else {
                completion(NO);
            }
        }else {
            [self->_delegate failedToFetchData:error];
            completion(NO);
        }
    }];
}


-(void)fetchFoodData : (void(^)(BOOL result))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=food"];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:url
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *food = [self parseImageData:data withCategory:FOOD];
            if(food) {
                [self.categoryMaster addObject:food];
                completion(YES);
            }else {
                completion(NO);
            }
        }else {
            [self->_delegate failedToFetchData:error];
            completion(NO);
        }
    }];
}

-(NSString*)imageCategoryFor:(CATEGORIES)category {
    
    switch (category) {
        case NATURE:
            return @"Nature";
        case SCIENCE:
            return @"Science";
        case EDUCATION:
            return @"Education";
        case FOOD:
            return @"Food";
        default:
            return @"New-Category";
    }
}

-(ImagesCategory*)parseImageData:(NSData*)data withCategory : (CATEGORIES) category {
    
    @try {
        NSError *error = nil ;
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments error:&error];
           NSMutableArray *allImages = [[NSMutableArray alloc]init];
           NSMutableArray *hits = dict[@"hits"];
           for (NSDictionary *currentObj in hits) {
               ImageDetails *details = [[ImageDetails alloc] init];
               [details setValuesForKeysWithDictionary:currentObj];
               [allImages addObject:details];
           }
        if ([allImages count]) {
            return [[ImagesCategory alloc]
            initWithTitle:[self imageCategoryFor:category]
            andImages:allImages];
        }
    } @catch (NSException *exception) {
        NSLog(@"Error %@", exception.description);
    }
    return nil;
}

@end
