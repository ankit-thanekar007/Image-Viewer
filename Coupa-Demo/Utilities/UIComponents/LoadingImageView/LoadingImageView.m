//
//  LoadingImageView.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "LoadingImageView.h"

@interface LoadingImageView ()
@property (nonatomic) UIView* containerView;
@end

@implementation LoadingImageView


-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self prepareContainer];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self prepareContainer];
    return self;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

-(void)prepareContainer{
    UINib *nib = [UINib nibWithNibName:@"LoadingImageView" bundle:[NSBundle mainBundle]];
    _containerView = [nib instantiateWithOwner:self options:nil][0];
    
    [self addSubview:_containerView];
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [_containerView.topAnchor constraintEqualToAnchor:[self topAnchor]],
        [_containerView.bottomAnchor constraintEqualToAnchor:[self bottomAnchor]],
        [_containerView.leftAnchor constraintEqualToAnchor:[self leftAnchor]],
        [_containerView.rightAnchor constraintEqualToAnchor:[self rightAnchor]]
    ]];
}

-(void)setImage:(UIImage*)image {
    dispatch_async(dispatch_get_main_queue(), ^(void){
           [self->_imageV setImage:image];
    });
}

-(void)startLoading {
    dispatch_async(dispatch_get_main_queue(), ^(void){
           [self->_loader startAnimating];
    });
    
}

-(void)stopLoading {
    dispatch_async(dispatch_get_main_queue(), ^(void){
           [self->_loader stopAnimating];
    });
}

@end
