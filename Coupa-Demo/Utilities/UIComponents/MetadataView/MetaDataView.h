//
//  MetaDataView.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 29/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MetaDataView : UIView

@property (nonatomic) IBOutlet UIImageView *metaDataImage;
@property (nonatomic) IBOutlet UILabel *metaInfoLabel;


-(void)setImage:(UIImage*)image andData : (NSString*)data;

@end

NS_ASSUME_NONNULL_END
