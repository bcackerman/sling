//
//  QUIAppDelegate.h
//  Quid
//
//  Created by Josh Holat on 7/6/13.
//  Copyright (c) 2013 Josh Holat. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

@interface QUIAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate, AVCaptureFileOutputRecordingDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem* statusItem;
    
    AVCaptureSession *mSession;
    AVCaptureMovieFileOutput *mMovieFileOutput;
}

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
