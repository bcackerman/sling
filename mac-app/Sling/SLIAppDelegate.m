//
//  SLIAppDelegate.m
//  Sling
//
//  Created by Josh Holat on 8/19/13.
//  Copyright (c) 2013 Sling. All rights reserved.
//

#import "SLIAppDelegate.h"
#import "AFNetworking.h"

@implementation SLIAppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    counter = 3;
}

- (void)awakeFromNib
{
    [statusMenu setDelegate:self];
    [statusMenu setAutoenablesItems:NO];
    
    // Add the various needed menu items to the menu
    NSMenuItem *recordMenuItem = [[NSMenuItem alloc] initWithTitle:@"Start Recording" action:@selector(almostStartRecording:) keyEquivalent:@"R"];
    [recordMenuItem setToolTip:@"Start recording your entire screen"];
    [statusMenu addItem:recordMenuItem];
    
    [statusMenu addItem:[NSMenuItem separatorItem]];
    
    NSMenuItem *settingsMenuItem = [[NSMenuItem alloc] initWithTitle:@"Settings" action:@selector(openSettings:) keyEquivalent:@""];
    [settingsMenuItem setToolTip:@"Start recording your entire screen"];
    [statusMenu addItem:settingsMenuItem];
    
    NSMenuItem *quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quit) keyEquivalent:@""];
    [statusMenu addItem:quitMenuItem];
    
    // Add our main status bar item to attach the menu to
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:[NSImage imageNamed:@"status_bar_icon.png"]];
    [statusItem setHighlightMode:YES];
}

- (void)quit
{
    [NSApp terminate:self]; // Go to sleep now... everything is going to be okay
}

- (void)almostStartRecording:(NSMenuItem*)sender
{
    // Set a timer to fire every second as an initial countdown until the recording will start
    [statusItem setTitle:[NSString stringWithFormat:@"%d", counter]];
    NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                               target:self
                                                             selector:@selector(advanceTimer:)
                                                             userInfo:sender
                                                              repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:countdownTimer forMode:NSDefaultRunLoopMode];
}

- (void)advanceTimer:(NSTimer *)timer
{
    // For each advance of the timer, update our counter and various UI states
    counter--;
    [statusItem setTitle:[NSString stringWithFormat:@"%d", counter]];
    if (counter <= 0) {
        [statusItem setImage:[NSImage imageNamed:@"status_bar_icon.png"]];
        [self startRecording:(NSMenuItem*)timer.userInfo];
        [timer invalidate];
        counter = 3;
    }
}

- (void)startRecording:(NSMenuItem *)sender
{
    // Set the menu item to make more sense now that we are recording
    [sender setAction:@selector(stopRecording:)];
    [sender setToolTip:@"Stop the current recording"];
    [sender setTitle:@"Stop Recording"];
    
    mSession = [[AVCaptureSession alloc] init];
    if ([mSession canSetSessionPreset:AVCaptureSessionPresetMedium]) {
        [mSession setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    // If you're on a multi-display system and you want to capture a secondary display,
    // you can call CGGetActiveDisplayList() to get the list of all active displays.
    // Create a ScreenInput with the display and add it to the session
    AVCaptureScreenInput *mMovieFileInput = [[AVCaptureScreenInput alloc] initWithDisplayID:kCGDirectMainDisplay];
    if ([mSession canAddInput:mMovieFileInput]) {
        [mSession addInput:mMovieFileInput];
    }
    
    // Add the main audio input device to the recording as well
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput * audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    [mSession addInput:audioInput];
    
    // Create a MovieFileOutput and add it to the session
    mMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    if ([mSession canAddOutput:mMovieFileOutput]) {
        [mSession addOutput:mMovieFileOutput];
    }
    
    [mSession startRunning];
    
    NSURL *destPath = [NSURL fileURLWithPath:[@"~/Desktop/Quid_Recording.mov" stringByExpandingTildeInPath]];
    
    // Delete any existing movie file first
    if ([[NSFileManager defaultManager] fileExistsAtPath:[destPath path]]) {
        NSError *err;
        if (![[NSFileManager defaultManager] removeItemAtPath:[destPath path] error:&err]) {
            NSLog(@"Error deleting existing movie %@",[err localizedDescription]);
        }
    }
    
    // Start recording to the destination movie file
    // The destination path is assumed to end with ".mov", for example, @"/users/master/desktop/capture.mov"
    // Set the recording delegate to self
    [mMovieFileOutput startRecordingToOutputFileURL:destPath recordingDelegate:self];
}

- (void)stopRecording:(NSMenuItem *)sender
{
    // Stop recording to the destination movie file
    [mMovieFileOutput stopRecording];
    
    [sender setAction:@selector(startRecording:)];
    [sender setTitle:@"Start Recording"];
    [sender setToolTip:@"Start recording your entire screen"];
}

# pragma mark - AVCaptureFileOutputRecordingDelegate

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    // Setup an HTTP request to upload the data from this file to a server
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://stagebloc.com"]];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                         path:@""
                                                                   parameters:nil
                                                    constructingBodyWithBlock:^(id <AFMultipartFormData>formData) {
                                                        [formData appendPartWithFileData:[NSData dataWithContentsOfURL:outputFileURL]
                                                                                    name:@"video"
                                                                                fileName:@"Quid_Recording.mov"
                                                                                mimeType:@"image/mov"];
                                                    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        //NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", [operation responseString]);
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Error: %@", error.localizedDescription);
                                     }];
    [httpClient enqueueHTTPRequestOperation:operation];
    
    // Stop running the session
    [mSession stopRunning];
}

# pragma mark - Core Data

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.holat.quid.Quid" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"com.holat.quid.Quid"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Quid" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"Quid.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        
        // Customize this code block to include application-specific recovery steps.
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }
    
    return NSTerminateNow;
}

@end