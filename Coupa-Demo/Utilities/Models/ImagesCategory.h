//
//  ImagesCategory.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImagesCategory : NSObject

-(instancetype)initWithTitle:(NSString*)title
                   andImages:(NSMutableArray<ImageDetails*>*)imageMaster;

@property (nonatomic) NSString* title;
@property (nonatomic) NSMutableArray<ImageDetails*>* imageMaster;

@end

NS_ASSUME_NONNULL_END
