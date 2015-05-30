//
//  DevBoxBetaAppDelegate.m
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 09-11-10.
//  Copyright 2010 UVM. All rights reserved.
//
#import "DropboxSDK.h"
#import "DevBoxBetaAppDelegate.h"
#import "RootViewController.h"
#import "TestView2.h"

@interface DevBoxBetaAppDelegate () <DBSessionDelegate>

@end


@implementation DevBoxBetaAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize rootViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Inicio sesion en dropbox
	
	// Set these variables before launching the app
    NSString* consumerKey = @"fxpudhyric2fi9l";
	NSString* consumerSecret = @"siiqjtc1wid5qvr";
	
	// Look below where the DBSession is created to understand how to use DBSession in your app
	
	NSString* errorMsg = nil;
	if ([consumerKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the consumer key correctly in DBRouletteAppDelegate.m";
	} else if ([consumerSecret rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the consumer secret correctly in DBRouletteAppDelegate.m";
	}
	
	DBSession* session = 
	[[DBSession alloc] initWithConsumerKey:consumerKey consumerSecret:consumerSecret];
	session.delegate = self; // DBSessionDelegate methods allow you to handle re-authenticating
	[DBSession setSharedSession:session];
    [session release];
	
	if (errorMsg != nil) {
		[[[[UIAlertView alloc]
		   initWithTitle:@"Error Configuring Session" message:errorMsg 
		   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
		  autorelease]
		 show];
	}
	
	// fin inicio de sesion
    
    // Add the navigation controller's view to the window and display.
	rootViewController.testView2 = [[TestView2 new] autorelease];
	if ([[DBSession sharedSession] isLinked]) {
       // navigationController.viewControllers = [NSArray arrayWithObjects:rootViewController, rootViewController.testView2, nil];
    }
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark DBSessionDelegate methods

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session {
	DBLoginController* loginController = [[DBLoginController new] autorelease];
	[loginController presentFromController:navigationController];
}


@end

