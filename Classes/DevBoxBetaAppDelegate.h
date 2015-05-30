//
//  DevBoxBetaAppDelegate.h
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 09-11-10.
//  Copyright 2010 UVM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface DevBoxBetaAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	RootViewController *rootViewController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end

