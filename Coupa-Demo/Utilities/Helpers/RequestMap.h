//
//  RequestMap.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 01/03/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagesCategory.h"
#import "ImageDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestMap : NSObject

typedef void (^RequestMapCompletionHandler)(BOOL result, ImagesCategory * _Nullable category);

-(void)fetchNatureDataWithURL :(NSString*)url and: (RequestMapCompletionHandler)completion;
-(void)fetchScienceDataWithURL :(NSString*)url and:  (RequestMapCompletionHandler)completion;
-(void)fetchEducationDataWithURL :(NSString*)url and:  (RequestMapCompletionHandler)completion;
-(void)fetchFoodDataWithURL :(NSString*)url and:  (RequestMapCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
