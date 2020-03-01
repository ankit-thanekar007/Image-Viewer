//
//  DetailsCell.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "DetailsCell.h"

@implementation DetailsCell

{
    NSString *currentURL ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [[AsyncImageManager sharedInstance] cancelTaskFor:currentURL];
}

-(void)setCellData : (ImageDetails*)details {
    [_detailedImage startLoading];
    currentURL = details.largeImageURL;
    [[AsyncImageManager sharedInstance] downloadImageWithURL:details.largeImageURL onCompletion:^(BOOL result, UIImage * _Nonnull image) {
        if(result) {
            [self->_detailedImage setImage:image];
        }else {
            UIImage *placeholder = [UIImage imageNamed:@"download_failed"];
            [self->_detailedImage setImage:placeholder];
        }
        [self->_detailedImage stopLoading];
    }];
}


@end
