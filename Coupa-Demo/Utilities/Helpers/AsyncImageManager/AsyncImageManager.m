//
//  AsyncImageManager.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "AsyncImageManager.h"
#import "NetworkWrapper.h"

@interface AsyncImageManager()

@property (nonatomic) NSCache *imageCache;
@property (nonatomic) NSMutableDictionary<NSString*, NSURLSessionTask*> *urlDict;

@end

@implementation AsyncImageManager


+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


-(instancetype)init{
    self = [super init];
    _imageCache = [[NSCache alloc]init];
    _urlDict = [NSMutableDictionary dictionary];
    return self;
}


-(void)downloadImageWithURL : (NSString*) url
               onCompletion : (void(^)(BOOL result, UIImage *image))completion {
    
    UIImage *image = [_imageCache objectForKey:url];
    if(image != NULL){
        completion(YES, image);
        return;
    }
    
    NetworkWrapper *wrapper = [[NetworkWrapper alloc]init];
    
   NSURLSessionTask *task = [wrapper GET:url completion:^(BOOL result,
   NSData *data,
   NSError *error,
   NSURLResponse *response) {
        if(result) {
            UIImage *image = [UIImage imageWithData:data];
            [self->_imageCache setObject:image forKey:response.URL.absoluteString];
            [self->_urlDict removeObjectForKey:response.URL.absoluteString];
            completion(YES, image);
        }else {
            completion(NO, nil);
        }
    }];
    [_urlDict setValue:task forKey:url];
}

-(void)cancelTaskFor:(NSString*) uuid {
    NSURLSessionTask *task = [_urlDict objectForKey:uuid];
    if(task) {
        [task cancel];
    }
}

-(void) cancelAll {
    [_urlDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSURLSessionTask * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    [_urlDict removeAllObjects];
}

-(void)clearCache {
    [self cancelAll];
    [self.imageCache removeAllObjects];
    [self.urlDict removeAllObjects];
}

@end
