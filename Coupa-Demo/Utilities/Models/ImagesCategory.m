//
//  ImagesCategory.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "ImagesCategory.h"

@implementation ImagesCategory

-(instancetype)initWithTitle:(NSString *)title andImages:(NSMutableArray<ImageDetails *> *)imageMaster {
    self = [super init];
    if(self) {
        _title = title;
        _imageMaster = imageMaster;
    }
    return self;
}

@end
