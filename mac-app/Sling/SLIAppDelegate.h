//
//  SLIAppDelegate.h
//  Sling
//
//  Created by Josh Holat on 8/19/13.
//  Copyright (c) 2013 Sling. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

@interface SLIAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate, AVCaptureFileOutputRecordingDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    int counter;
    
    AVCaptureSession *mSession;
    AVCaptureMovieFileOutput *mMovieFileOutput;
}

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
