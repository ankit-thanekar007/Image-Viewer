//
//  NetworkWrapper.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkWrapper : NSObject

-(NSURLSessionTask*)GET:(NSString*)urlString completion:(void(^)(BOOL result,
                                                                 NSData *data,
                                                                 NSError *error,
                                                                 NSURLResponse *response))callback;

@end

NS_ASSUME_NONNULL_END
