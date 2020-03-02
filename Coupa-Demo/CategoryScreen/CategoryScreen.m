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
    BOOL shouldRefresh;
}

-(CategoryDataController*)dataController {
    return [CategoryDataController sharedInstance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _master = [NSMutableArray array];
    [self setupRefreshControl];
    [self fetchData];
    [_tableView setEstimatedRowHeight:UITableViewAutomaticDimension];
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
    [self setEdgesForExtendedLayout:UIRectEdgeTop];
    [self setExtendedLayoutIncludesOpaqueBars:YES];
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
    [_loader stopAnimating];
    if([[_tableView refreshControl] isRefreshing]) {
        [[_tableView refreshControl] endRefreshing];
    }
}

#pragma mark Category Delegate Methods

-(void)addedDataToCategories:(NSMutableArray<ImagesCategory *> *)values {
    _master = values;
    if(![_master count]){
        _fetchingFailedViewLabel.text = @"No Results Found! Please Pull Down to Refresh!";
    }
    [self stopRelatedLoaders];
    [_tableView setHidden:NO];
    
//    if(!shouldRefresh) {
        shouldRefresh = YES;
        [_tableView reloadData];
//    }
}

- (void)failedToFetchData:(nonnull NSError *)error {
    _fetchingFailedViewLabel.text = @"Error in fetching, Seems servers are down,Please try after some time!";
    [_tableView setHidden:NO];
    [self stopRelatedLoaders];
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
    if([_master count] > 0) {
        [tableView.backgroundView setHidden:YES];
    }else {
        [tableView.backgroundView setHidden:NO];
    }
    
    return [_master count];
}

#pragma mark TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedCategory = [_master objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewDetailsSegue" sender:self];
}

#pragma mark ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [[_tableView refreshControl] beginRefreshing];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if([[_tableView refreshControl] isRefreshing]) {
        [[_tableView refreshControl] endRefreshing];
    }
    [_tableView reloadData];
}

@end

