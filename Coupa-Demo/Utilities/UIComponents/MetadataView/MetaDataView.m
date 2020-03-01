//
//  MetaDataView.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "MetaDataView.h"

@interface MetaDataView ()

@property (nonatomic) UIView* containerView;

@end

@implementation MetaDataView

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
    UINib *nib = [UINib nibWithNibName:@"MetaDataView" bundle:[NSBundle mainBundle]];
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


#pragma mark Set Information

-(void)setImage:(UIImage*)image andData : (NSString*)data {
    _metaDataImage.image = image;
    _metaInfoLabel.text = data;
}

@end
