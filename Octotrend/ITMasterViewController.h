//
//  ITMasterViewController.h
//  Octotrend
//
//  Created by Tiago Alves on 15/12/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "BSRefreshableScrollView.h"

@interface ITMasterViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSMutableArray *repositories;

@property (nonatomic, strong) IBOutlet BSRefreshableScrollView *scrollView;
@property (nonatomic, strong) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) IBOutlet WebView *webview;

@end
