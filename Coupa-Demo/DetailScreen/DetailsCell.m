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
    [self.detailedImage setImage:nil];
    [self.viewsView setImage:nil];
    [self.downloadsView setImage:nil];
    [self.favoritesView setImage:nil];
    [self.likesView setImage:nil];
}

-(void)setCellData : (ImageDetails*)details {
    
    [self setLikes: [@(details.likes) stringValue]];
    [self setFavorites: [@(details.favorites) stringValue]];
    [self setDownloads: [@(details.downloads) stringValue]];
    [self setViews: [@(details.views) stringValue]];
    
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




@end
