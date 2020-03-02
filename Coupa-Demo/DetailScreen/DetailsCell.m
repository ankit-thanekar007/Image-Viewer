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
    ImageDetails *details;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [self.detailedImage setImage:nil];
    [self.viewsView setImage:nil];
    [self.downloadsView setImage:nil];
    [self.favoritesView setImage:nil];
    [self.likesView setImage:nil];
}

-(void)setCellData : (ImageDetails*)d atIndex : (int) row {
    [self setIndexOfCell:row];
    details = d;
    if([details shouldRetry]) {
        [self errorSet];
    }else {
        [self successSet];
    }
}


-(void)successSet {
    [self setLikes: [@(details.likes) stringValue]];
    [self setFavorites: [@(details.favorites) stringValue]];
    [self setDownloads: [@(details.downloads) stringValue]];
    [self setViews: [@(details.views) stringValue]];
    [self fetchImage];
}

-(void)errorSet {
    [self.detailedImage stopLoading];
    [[self retryButton] setHidden:NO];
    [_metaStack setHidden:YES];
}

-(void)fetchImage {
    [[self retryButton] setHidden:YES];
    [_metaStack setHidden:NO];
    [_detailedImage startLoading];
    currentURL = details.largeImageURL;
    [[AsyncImageManager sharedInstance] downloadImageWithURL:currentURL onCompletion:^(BOOL result, UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if(result) {
                self.detailedImage.imageV.image = image;
            }else {
                [self errorSet];
//                UIImage *placeholder = [UIImage imageNamed:@"download_failed"];
//                self.detailedImage.imageV.image = placeholder;
            }
            [self.detailedImage stopLoading];
            [self setNeedsDisplay];
        });
    }];
}


-(void)setLikes : (NSString*)data {
    [_likesView setImage:[UIImage imageNamed:@"likes"] andData:data];
}

-(void)setFavorites: (NSString*)data {
    [_favoritesView setImage:[UIImage imageNamed:@"favourites"] andData:data];
}

-(void)setViews: (NSString*)data {
    [_viewsView setImage:[UIImage imageNamed:@"views"] andData:data];
}

-(void)setDownloads: (NSString*)data {
    [_downloadsView setImage:[UIImage imageNamed:@"downloads"] andData:data];
}

- (IBAction)shouldRetry:(UIButton*)sender {
    [self fetchImage];
}


@end
