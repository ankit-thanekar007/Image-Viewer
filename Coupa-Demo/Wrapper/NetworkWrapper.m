//
//  NetworkWrapper.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "NetworkWrapper.h"

@implementation NetworkWrapper

-(NSURLSessionTask*)GET:(NSString*)urlString completion:(void(^)(BOOL result,
                                                                 NSData *data,
                                                                 NSError *error,
                                                                 NSURLResponse *response))callback {
    
    NSLog(@"############ URL START ################");
    NSLog(@"URL: %@", urlString);
    NSLog(@"############ URL END ################");
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";

    NSError *error = nil;

    if (!error) {
        
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                callback(NO, nil, error, response);
            }else {
                callback(YES, data, error, response);
            }
        } ];
        [task resume];
        return task;
    }
    callback(NO, nil, nil, nil);
    return nil;
}

@end
