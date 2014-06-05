//
//  ITMasterViewController.m
//  Octotrend
//
//  Created by Tiago Alves on 15/12/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import "ITMasterViewController.h"
#import "Repository.h"

#import "ITRepoCellView.h"

#define kMinSplitViewWidth 250.0
#define kMaxSplitViewWidth 700.0

@interface ITMasterViewController () <NSSplitViewDelegate>

@end

@implementation ITMasterViewController

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
        cellView.descriptionLabel.stringValue = repo.description;
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

@end
