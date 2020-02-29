//
//  LoadingImageView.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingImageView : UIView

@property (nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic) IBOutlet UIActivityIndicatorView *loader;

-(void)setImage:(UIImage*)image;
-(void)startLoading ;
-(void)stopLoading ;
@end

NS_ASSUME_NONNULL_END
