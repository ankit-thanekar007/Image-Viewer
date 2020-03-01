//
//  CategoryScreen.m
//  Coupa-Demo
//
//  Created by Ankit Thanekar on 28/02/20.
//  Copyright © 2020 Ankit Thanekar. All rights reserved.
//

#import "CategoryScreen.h"
#import "CategoryDataController.h"
#import "CategoryCell.h"
#import "DetailScreen.h"

@interface CategoryScreen ()
@property (nonatomic) NSMutableArray<ImagesCategory*>* master;
@property IBOutlet UITableView *tableView;
@property IBOutlet UIActivityIndicatorView *loader;
@property IBOutlet UIView *fetchingFailedView;
@property IBOutlet UILabel *fetchingFailedViewLabel;
@end

@implementation CategoryScreen
{
    ImagesCategory *selectedCategory;
}

-(CategoryDataController*)dataController {
    return [CategoryDataController sharedInstance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefreshControl];
    [self fetchData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString: @"ViewDetailsSegue"]){
        DetailScreen *ds = segue.destinationViewController;
        ds.selectedCategory = selectedCategory;
    }
}

-(void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    _tableView.refreshControl = refreshControl;
    [_tableView.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [[_tableView refreshControl] endRefreshing];
}

-(void)fetchData {
    [self startRelatedLoaders];
    [_tableView setHidden:YES];
    [_tableView setBackgroundView:_fetchingFailedView];
    [[self dataController] setDelegate:self];
    [[self dataController] fetchCategoryMasterData];
}

-(void)startRelatedLoaders {
    if(![_tableView.refreshControl isRefreshing]) {
        [_loader startAnimating];
    }
}

-(void)stopRelatedLoaders {
    [[_tableView refreshControl] endRefreshing];
    [_loader stopAnimating];
}

#pragma mark Category Delegate Methods

-(void)addedDataToCategories:(NSMutableArray<ImagesCategory *> *)values {
    _master = values;
    if(![_master count]){
        _fetchingFailedViewLabel.text = @"No Results Found! Please Pull Down to Refresh!";
    }
    [self stopRelatedLoaders];
    [_tableView setHidden:NO];
    [_tableView reloadData];
}

- (void)failedToFetchData:(nonnull NSError *)error {
    _fetchingFailedViewLabel.text = @"Error in fetching, Seems servers are down,Please try after some time!";
    [_tableView setHidden:NO];
    [self stopRelatedLoaders];
    NSLog(@"Values %@", error);
}

#pragma mark TableView Data Source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryCell *cell = (CategoryCell*)[tableView
                                         dequeueReusableCellWithIdentifier:@"CategoryCell"
                                         forIndexPath:indexPath];
    [cell setCellData:_master[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView.backgroundView setHidden:[_master count]];
    return [_master count];
}

#pragma mark TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedCategory = [_master objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewDetailsSegue" sender:self];
}

@end

