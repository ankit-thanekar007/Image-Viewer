//
//  RequestMap.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 01/03/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "RequestMap.h"
#import "NetworkWrapper.h"

typedef enum : NSUInteger {
    NATURE,
    SCIENCE,
    EDUCATION,
    FOOD
} CATEGORIES;

@implementation RequestMap
//NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=nature"];
//NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=science"];
//NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=education"];
//NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"&category=food"];


-(void)fetchByTitle:(NSString*)title
            forURL : (NSString*)url
                and: (RequestMapCompletionHandler)completion {
    if ([title isEqualToString: @"Education"]){
        [self fetchEducationDataWithURL:url and:completion];
    }else if ([title isEqualToString: @"Food"]){
        [self fetchFoodDataWithURL:url and:completion];
    }else if ([title isEqualToString: @"Nature"]){
        [self fetchNatureDataWithURL:url and:completion];
    }else if ([title isEqualToString: @"Science"]){
        [self fetchScienceDataWithURL:url and:completion];
    }
}


-(void)fetchNatureDataWithURL :(NSString*)url and: (RequestMapCompletionHandler)completion {
    NSString *baseURL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:baseURL
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *nature = [self parseImageData:data withCategory:NATURE];
            if(nature) {
                completion(YES, nature);
            }else {
                completion(NO, nil);
            }
        }else {
            completion(NO, nil);
        }
    }];
}

-(void)fetchScienceDataWithURL :(NSString*)url and:  (RequestMapCompletionHandler)completion {
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:baseURL
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *science = [self parseImageData:data withCategory:SCIENCE];
            if(science) {
//                [self.categoryMaster addObject:science];
                completion(YES, science);
            }else {
                completion(NO, nil);
            }
        }else {
//            [self->_delegate failedToFetchData:error];
            completion(NO, nil);
        }
    }];
}

-(void)fetchEducationDataWithURL :(NSString*)url and: (RequestMapCompletionHandler)completion {
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:baseURL
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *education = [self parseImageData:data withCategory:EDUCATION];
            if(education) {
//                [self.categoryMaster addObject:education];
                completion(YES, education);
            }else {
                completion(NO, nil);
            }
        }else {
//            [self->_delegate failedToFetchData:error];
            completion(NO, nil);
        }
    }];
}


-(void)fetchFoodDataWithURL :(NSString*)url and: (RequestMapCompletionHandler)completion {
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    __unused NSURLSessionTask *task = [wrapper GET:baseURL
                                        completion:^(BOOL result,
                                        NSData *data,
                                        NSError *error,
                                        NSURLResponse *response) {
        if(result) {
            ImagesCategory *food = [self parseImageData:data withCategory:FOOD];
            if(food) {
//                [self.categoryMaster addObject:food];
                completion(YES, food);
            }else {
                completion(NO, nil);
            }
        }else {
//            [self->_delegate failedToFetchData:error];
            completion(NO, nil);
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
