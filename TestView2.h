//
//  TestView2.h
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 09-11-10.
//  Copyright 2010 UVM. All rights reserved.
//

@class DBRestClient;

#import <UIKit/UIKit.h>
#import "TextEditViewController.h"
#import "DropboxSDK.h"
#import <stdlib.h>


@interface TestView2 : UITableViewController  <DBRestClientDelegate>{
	
	DBRestClient* restClient;
	NSArray *tutorial;
	NSString* filePath, *to_path, *pathAuxFile;
	UIViewController* testView3;
	UIViewController* textEditor;
	BOOL working;
	UIView* activityView;
	

}


@property (nonatomic, retain) UIViewController* testView3;
@property (nonatomic, retain) UIViewController* textEditor;
@property (nonatomic, retain) NSString* filePath, *to_path, *pathAuxFile;
@property (nonatomic, retain) UIView* activityView;
@property (nonatomic, readonly) DBRestClient* restClient;

-(id)initWithFilePath:(NSString*)initPath;
- (NSString*)auxPath:(NSString*)name;
- (void)setWorking:(BOOL)isWorking;

@end
