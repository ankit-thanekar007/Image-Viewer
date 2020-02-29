//
//  CategoryCell.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "CategoryCell.h"
#import "ImageDetails.h"
#import "AsyncImageManager.h"

@interface CategoryCell()

@property (nonatomic) NSString *image1URL ;
@property (nonatomic) NSString *image2URL ;
@property (nonatomic) NSString *image3URL ;
@property (nonatomic) NSString *image4URL ;

@end

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    [[AsyncImageManager sharedInstance] cancelTaskFor: _image1URL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCellData:(ImagesCategory *)category {
    self.category.text = category.title;
    
    [_image_1 startLoading];
    _image1URL = category.imageMaster[0].previewURL;
    [[AsyncImageManager sharedInstance] downloadImageWithURL:_image1URL onCompletion:^(BOOL result, UIImage * _Nonnull image) {
        if(result) {
            [self->_image_1 setImage:image];
        }else {
            UIImage *placeholder = [UIImage imageNamed:@"download_failed"];
            [self->_image_1 setImage:placeholder];
        }
        [self->_image_1 stopLoading];
    }];
    
    [_image_2 startLoading];
    _image2URL = category.imageMaster[1].previewURL;
    [[AsyncImageManager sharedInstance] downloadImageWithURL:_image2URL onCompletion:^(BOOL result, UIImage * _Nonnull image) {
        if(result) {
            [self->_image_2 setImage:image];
        }else {
            UIImage *placeholder = [UIImage imageNamed:@"download_failed"];
            [self->_image_2 setImage:placeholder];
        }
        [self->_image_2 stopLoading];
    }];
    
    [_image_3 startLoading];
    _image3URL = category.imageMaster[2].previewURL;
    [[AsyncImageManager sharedInstance] downloadImageWithURL:_image3URL onCompletion:^(BOOL result, UIImage * _Nonnull image) {
        if(result) {
            [self->_image_3 setImage:image];
        }else {
            UIImage *placeholder = [UIImage imageNamed:@"download_failed"];
            [self->_image_3 setImage:placeholder];
        }
        [self->_image_3 stopLoading];
    }];
    
    [_image_4 startLoading];
    _image4URL = category.imageMaster[3].previewURL;
    [[AsyncImageManager sharedInstance] downloadImageWithURL:_image4URL onCompletion:^(BOOL result, UIImage * _Nonnull image) {
        if(result) {
            [self->_image_4 setImage:image];
        }else {
            UIImage *placeholder = [UIImage imageNamed:@"download_failed"];
            [self->_image_4 setImage:placeholder];
        }
        [self->_image_4 stopLoading];
    }];
}

@end
