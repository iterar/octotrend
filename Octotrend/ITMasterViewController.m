//
//  ITMasterViewController.m
//  Octotrend
//
//  Created by Tiago Alves on 15/12/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import "ITMasterViewController.h"
#import "Repository.h"

@interface ITMasterViewController ()

@end

@implementation ITMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 32;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if( [tableColumn.identifier isEqualToString:@"RepoColumn"] )
    {
        Repository *repo = [self.repositories objectAtIndex:row];
        cellView.textField.stringValue = repo.name;
        return cellView;
    }
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

@end
