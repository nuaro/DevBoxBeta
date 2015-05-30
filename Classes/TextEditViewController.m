//
//  TextEditViewController.m
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 26-11-10.
//  Copyright 2010 UVM. All rights reserved.
//

#import "TextEditViewController.h"

@implementation TextEditViewController

@synthesize textContent, filePath , savePath, currentFile;

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


-(id)initWithFilePath:(NSString*)initPath toPath:(NSString*)to_path
{
	self = [super init];
	if (self != nil) {
		
		//set the file path
		if (initPath != nil) {
			self.filePath = initPath;
			currentFile = [[TextEditor alloc] initWithFilePath:self.filePath];
			[currentFile loadFile];
			self.savePath = to_path;
			
		}
		
	}
	return self;
}

- (void)viewDidLoad {
	[self initializeView];
	[super viewDidLoad];
}



-(void)initializeView {
	
	// las tres lineas siguientes debieran ser dinamicas
	
	self.textContent.font = [UIFont fontWithName:@"DejaVu Sans Mono" size:10.0f];
	
	//NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	//NSString* documentsDir = [paths objectAtIndex:0];
	//NSString* filePath = [documentsDir stringByAppendingPathComponent:@"main.m"];
	
	
	
	//cambio nombre de titulo
	self.title = currentFile.fileName;
	//self.fileName.text = currentFile.fileName;
	self.textContent.text = currentFile.fileContent;
	
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (viewPushed) {
        viewPushed = NO; // Flag indicates that view disappeared because we pushed another controller onto the navigation controller, we acknowledge it here
	} else {
        self.currentFile.fileContent = self.textContent.text;
		[currentFile saveFile];
		
		

	}   
}

- (void)dealloc {
	//[currentFile release];
    [super dealloc];
}





@end
