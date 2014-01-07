//
//  ITAppDelegate.h
//  Octotrend
//
//  Created by Tiago Alves on 15/12/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ITAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
