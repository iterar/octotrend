//
//  ITRepoCellView.h
//  Octotrend
//
//  Created by Tiago Alves on 08/01/14.
//  Copyright (c) 2014 Iterar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ITRepoCellView : NSTableRowView {
    NSColor *color;
}

@property (nonatomic) NSInteger rowIndex;

@property (nonatomic, strong) IBOutlet NSTextField *nameLabel;
@property (nonatomic, strong) IBOutlet NSTextField *descriptionLabel;
@property (nonatomic, strong) IBOutlet NSTextField *watchersCountLabel;
@property (nonatomic, strong) IBOutlet NSTextField *languageLabel;

@end
