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

-(void)setMasterCategory : (ImagesCategory*)category {
    _selectedCategory = category;
    [self splitMaster];
}

-(NSArray<ImageDetails*>*)getToBeUsed {
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

-(void)fetchDataFromRequestForReplacement:(int) row {
    RequestMap *map = [[RequestMap alloc] init];
    pageNumber = pageNumber + 1;
    NSString *pagedURL = [NSString stringWithFormat:@"&category=nature&per_page=20&page=%d", pageNumber] ;
    
    [map fetchNatureDataWithURL:pagedURL and:^(BOOL result, ImagesCategory * _Nullable category) {
        if(result) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                   [self handleRefreshParsing:category];
                   [self replaceImageAtIndex:row];
            });
        }else {
            //TODO: Handle Error
        }
    }];
}

-(void)handleRefreshParsing : (ImagesCategory*)fetchedCategory {
    _toBeRefreshed = [NSMutableArray arrayWithArray:[fetchedCategory imageMaster]];
}

@end
