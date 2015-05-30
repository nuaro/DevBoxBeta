//
//  RootViewController.h
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 09-11-10.
//  Copyright 2010 UVM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBRestClient;

@interface RootViewController : UIViewController <DBLoginControllerDelegate> {
	
	UIViewController* testView2;
	DBRestClient* restClient;

}

@property (nonatomic, retain) UIViewController* testView2;

- (IBAction)didPressLink:(id)sender;
-(void) segmentAction: (UISegmentedControl *) sender;
@end
