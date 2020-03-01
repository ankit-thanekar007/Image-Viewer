//
//  LoadingImageView.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface LoadingImageView : UIView

@property (nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (nonatomic) IBInspectable UIViewContentMode mode;

-(void)setImage:(nullable UIImage*)image;
-(void)startLoading ;
-(void)stopLoading ;
@end

NS_ASSUME_NONNULL_END
