//
//  ITRepoCellView.m
//  Octotrend
//
//  Created by Tiago Alves on 08/01/14.
//  Copyright (c) 2014 Iterar. All rights reserved.
//

#import "ITRepoCellView.h"

@implementation ITRepoCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

- (void)drawBackgroundInRect:(NSRect)dirtyRect {
    
    self.nameLabel.textColor = [NSColor colorWithRed:65.0/255.0 green:131.0/255.0 blue:196.0/255.0 alpha:1.0];
    self.descriptionLabel.textColor = [NSColor blackColor];
    self.watchersCountLabel.textColor = [NSColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0];
    self.languageLabel.textColor = [NSColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0];
    
    if (self.rowIndex % 2 == 0) {
        [[NSColor clearColor] setStroke];
        [[NSColor whiteColor] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:self.bounds];
        [selectionPath fill];
        [selectionPath stroke];
    } else {
        [[NSColor clearColor] setStroke];
        [[NSColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:self.bounds];
        [selectionPath fill];
        [selectionPath stroke];
    }
    
}

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        self.nameLabel.textColor = [NSColor whiteColor];
        self.descriptionLabel.textColor = [NSColor whiteColor];
        self.watchersCountLabel.textColor = [NSColor whiteColor];
        self.languageLabel.textColor = [NSColor whiteColor];
        [[NSColor clearColor] setStroke];
        [[NSColor colorWithRed:65.0/255.0 green:131.0/255.0 blue:196.0/255.0 alpha:1.0] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:self.bounds];
        [selectionPath fill];
        [selectionPath stroke];
    }
}

@end
