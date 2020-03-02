//
//  CategoryScreen.h
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryScreen : UIViewController<CategoryDataParsed, UITableViewDataSource, UITableViewDelegate>

@end

NS_ASSUME_NONNULL_END
