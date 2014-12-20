//
//  ITMasterViewController.m
//  Octotrend
//
//  Created by Tiago Alves on 15/12/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import "ITMasterViewController.h"
#import "Repository.h"
#import "AFNetworking.h"

#import "ITRepoCellView.h"

#define kMinSplitViewWidth 250.0
#define kMaxSplitViewWidth 700.0

@interface ITMasterViewController () <NSSplitViewDelegate>

@end

@implementation ITMasterViewController

- (void)awakeFromNib {
//    self.scrollView.refreshableSides = BSRefreshableScrollViewSideTop;
    [self refreshTableView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        [self.tableView setAllowsColumnResizing:YES];
        NSSplitView *splitView = (NSSplitView*)self.view;
        [splitView setDividerStyle:NSSplitViewDividerStyleThin];
        NSLog(@"Superview: %@", self.tableView.superview.superview.className);
        NSScrollView* scrollView = (NSScrollView*)self.tableView.superview.superview;
        scrollView.borderType = NSNoBorder;
    }
    return self;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 112;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    static NSString* const kRowIdentifier = @"RowView";
    ITRepoCellView *cellView = [tableView makeViewWithIdentifier:kRowIdentifier owner:self];
    [cellView setRowIndex:row];
//    if (!cellView) {
        Repository *repo = [self.repositories objectAtIndex:row];
        cellView.nameLabel.stringValue = repo.name;
        cellView.descriptionLabel.stringValue = repo.repo_description;
        cellView.languageLabel.stringValue = repo.language;
        cellView.watchersCountLabel.stringValue = [NSString stringWithFormat:@"Watchers: %@", [repo.watchersCount stringValue]];
        return cellView;
//    }
    
    return cellView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    Repository *selectedRepo = [self.repositories objectAtIndex:[self.tableView selectedRow]];
    NSLog(@"Repo selected is - %@", selectedRepo.name);
    NSURLRequest*request=[NSURLRequest requestWithURL:selectedRepo.url];
    [[self.webview mainFrame] loadRequest:request];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.repositories count];
}


- (void)refreshTableView {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Get date from one week ago
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    NSDateComponents *oneWeekAgoComponents = [[NSDateComponents alloc] init];
    [oneWeekAgoComponents setWeekOfYear:oneWeekAgoComponents.weekOfYear - 1];
    NSDate *twoWeeksAgo = [calendar dateByAddingComponents:oneWeekAgoComponents toDate:today options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:twoWeeksAgo];
    
    NSString *query = [NSString stringWithFormat:@"created:>%@", stringFromDate];
    NSDictionary *parameters = @{@"q": query};
    [manager GET:@"https://api.github.com/search/repositories" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *repos = [responseObject objectForKey:@"items"];
        NSMutableArray *reposArray = [[NSMutableArray alloc] initWithCapacity:repos.count];
        
        for (NSDictionary *currentRepo in repos) {
            Repository *repo = [[Repository alloc] init];
            repo.name = [currentRepo objectForKey:@"name"];
            repo.url = [NSURL URLWithString:[currentRepo objectForKey:@"html_url"]];
            repo.language = [currentRepo objectForKey:@"language"] == [NSNull null] ? @"" : [currentRepo objectForKey:@"language"];
            repo.repo_description = [currentRepo objectForKey:@"description"];
            repo.watchersCount = [currentRepo objectForKey:@"watchers_count"];
            [reposArray addObject:repo];
        }
        
        self.repositories = reposArray;
        [self.tableView reloadData];
        
        // Select first repository
        [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
        
        [self stopRefreshTop];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self stopRefreshTop];
    }];
}

#pragma mark Split view delegate methods

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)view {
    [self.tableView setNeedsDisplay];
    return YES;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return kMinSplitViewWidth;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
    return kMaxSplitViewWidth;
}

#pragma mark BSRefreshableScrollViewDelegate

-(BOOL) scrollView:(BSRefreshableScrollView*) aScrollView startRefreshSide:(BSRefreshableScrollViewSide) refreshableSide
{
    if (refreshableSide == BSRefreshableScrollViewSideTop) {
        [self refreshTableView];
        return YES; // tell the scroll view to display the progress indicator
    }
    return NO;
}

- (void)stopRefreshTop
{
    [self.scrollView stopRefreshingSide:BSRefreshableScrollViewSideTop];
}

@end
