//
//  ImageDetails.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDetails : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *pageURL;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *tags;
@property (nonatomic, copy)   NSString *previewURL;
@property (nonatomic, assign) NSInteger previewWidth;
@property (nonatomic, assign) NSInteger previewHeight;
@property (nonatomic, copy)   NSString *webformatURL;
@property (nonatomic, assign) NSInteger webformatWidth;
@property (nonatomic, assign) NSInteger webformatHeight;
@property (nonatomic, copy)   NSString *largeImageURL;
@property (nonatomic, assign) NSInteger imageWidth;
@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, assign) NSInteger imageSize;
@property (nonatomic, assign) NSInteger views;
@property (nonatomic, assign) NSInteger downloads;
@property (nonatomic, assign) NSInteger favorites;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy)   NSString *user;
@property (nonatomic, copy)   NSString *userImageURL;
@property BOOL shouldRetry;

//+ (_Nullable instancetype)fromJSON:(NSString *)json
//                          encoding:(NSStringEncoding)encoding
//                             error:(NSError *_Nullable *)error;
//
//+ (_Nullable instancetype)fromData:(NSData *)data
//                             error:(NSError *_Nullable *)error;
//
//- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding
//                        error:(NSError *_Nullable *)error;
//
//- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

NS_ASSUME_NONNULL_END
