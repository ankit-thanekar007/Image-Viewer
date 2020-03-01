//
//  AsyncImageManager.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsyncImageManager : NSObject

+ (instancetype)sharedInstance;

-(void)downloadImageWithURL : (NSString*) url
               onCompletion : (void(^)(BOOL result, UIImage *image))completion;

-(void)cancelTaskFor:(NSString*) uuid;
-(void) cancelAll ;
@end

NS_ASSUME_NONNULL_END
