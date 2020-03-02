//
//  DetailDataController.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "DetailDataController.h"
#import "NetworkWrapper.h"
#import "RequestMap.h"

@interface DetailDataController()

@property (nonatomic) ImagesCategory* selectedCategory;
@property (nonatomic) NSMutableArray<ImageDetails*>* toBeUsed;
@property (nonatomic) NSMutableArray<ImageDetails*>* toBeRefreshed;

@end

@implementation DetailDataController
{
    int pageNumber;
}

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

-(NSString*)getCategoryValue {
    NSString *title = _selectedCategory.title;
    if ([title isEqualToString: @"Education"]){
        return @"education";
    }else if ([title isEqualToString: @"Food"]){
        return @"food";
    }else if ([title isEqualToString: @"Nature"]){
        return @"nature";
    }else if ([title isEqualToString: @"Science"]){
        return @"science";
    }
    return @"q";
}


-(void)setMasterCategory : (ImagesCategory*)category {
    _selectedCategory = category;
    pageNumber = 1;
    [self splitMaster];
}

-(NSMutableArray<ImageDetails*>*)getToBeUsed {
    if(_toBeUsed) {
        return _toBeUsed;
    }
    return @[];
}

-(void)splitMaster {
    NSRange range;
    range.location = 0;
    range.length = _selectedCategory.imageMaster.count/2;
    
    _toBeUsed = [[_selectedCategory.imageMaster subarrayWithRange:range] mutableCopy];
    range.location = range.length;
    range.length = [_selectedCategory.imageMaster count] - range.length;
    
    _toBeRefreshed = [[_selectedCategory.imageMaster subarrayWithRange:range] mutableCopy];
}

-(void)replaceImageAtIndex:(int) row {
    if([_toBeRefreshed count] > 0) {
        [_toBeUsed removeObjectAtIndex:row];
        ImageDetails * detail = [_toBeRefreshed objectAtIndex:0];
        [_toBeRefreshed removeObjectAtIndex:0];
        [_toBeUsed insertObject:detail atIndex:row];
        [_delegate refreshCellAtIndex:row];
    }else {
        [self fetchDataFromRequestForReplacement:row];
    }
}

-(void)failedToFetchImageData:(int) row {
    [_delegate failedToFetch:row];
}

-(void)fetchDataFromRequestForReplacement:(int) row {
    RequestMap *map = [[RequestMap alloc] init];
    pageNumber = pageNumber + 1;
    NSString *pagedURL = [NSString stringWithFormat:@"&category=%@&per_page=20&page=%d",
                          [self getCategoryValue],
                          pageNumber] ;
    
    [map fetchByTitle:_selectedCategory.title forURL:pagedURL and:^(BOOL result, ImagesCategory * _Nullable category) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                if(result) {
                   [self handleRefreshParsing:category];
                   [self replaceImageAtIndex:row];
                }else {
                    self->pageNumber = self->pageNumber - 1;
                    [self failedToFetchImageData:row];
                }
            });
        
    }];
}

-(void)handleRefreshParsing : (ImagesCategory*)fetchedCategory {
    _toBeRefreshed = [NSMutableArray arrayWithArray:[fetchedCategory imageMaster]];
}

@end
