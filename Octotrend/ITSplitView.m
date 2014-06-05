//
//  ITSplitView.m
//  Octotrend
//
//  Created by Tiago Alves on 05/06/14.
//  Copyright (c) 2014 Iterar. All rights reserved.
//

#import "ITSplitView.h"

@implementation ITSplitView

- (NSColor*)dividerColor {
    return (self.DividerColor == nil) ? [NSColor redColor] : self.DividerColor;
}

-(void) drawRect {
    id topView = [[self subviews] objectAtIndex:0];
    NSRect topViewFrameRect = [topView frame];
    [self drawDividerInRect:NSMakeRect(topViewFrameRect.origin.x, topViewFrameRect.size.height, topViewFrameRect.size.width, [self dividerThickness] )];
}

-(void) drawDividerInRect:(NSRect)aRect {
    [[NSColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0] set];
    NSRectFill(aRect);
}

@end
