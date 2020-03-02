//
//  ImageDetails.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "ImageDetails.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface ImageDetails (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

ImageDetails *_Nullable ImageDetailsFromData(NSData *data, NSError **error) {
    
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [ImageDetails fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

ImageDetails *_Nullable ImageDetailsFromJSON(NSString *json, NSStringEncoding encoding, NSError **error){
    return ImageDetailsFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable ImageDetailsToData(ImageDetails *welcome, NSError **error){
    @try {
        id json = [welcome JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable ImageDetailsToJSON(ImageDetails *welcome, NSStringEncoding encoding, NSError **error){
    NSData *data = ImageDetailsToData(welcome, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation ImageDetails
+ (NSDictionary<NSString *, NSString *> *)properties{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"pageURL": @"pageURL",
        @"type": @"type",
        @"tags": @"tags",
        @"previewURL": @"previewURL",
        @"previewWidth": @"previewWidth",
        @"previewHeight": @"previewHeight",
        @"webformatURL": @"webformatURL",
        @"webformatWidth": @"webformatWidth",
        @"webformatHeight": @"webformatHeight",
        @"largeImageURL": @"largeImageURL",
        @"imageWidth": @"imageWidth",
        @"imageHeight": @"imageHeight",
        @"imageSize": @"imageSize",
        @"views": @"views",
        @"downloads": @"downloads",
        @"favorites": @"favorites",
        @"likes": @"likes",
        @"comments": @"comments",
        @"user_id": @"userID",
        @"user": @"user",
        @"userImageURL": @"userImageURL",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error {
    return ImageDetailsFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error {
    return ImageDetailsFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict{
    return dict ? [[ImageDetails alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key{
    id resolved = ImageDetails.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary{
    id dict = [[self dictionaryWithValuesForKeys:ImageDetails.properties.allValues] mutableCopy];
    
    // Rewrite property names that differ in JSON
    for (id jsonName in ImageDetails.properties) {
        id propertyName = ImageDetails.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error{
    return ImageDetailsToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error{
    return ImageDetailsToJSON(self, encoding, error);
}
@end

NS_ASSUME_NONNULL_END
