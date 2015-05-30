//
//  RootViewController.m
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 09-11-10.
//  Copyright 2010 UVM. All rights reserved.
//
#import "DropboxSDK.h"
#import "RootViewController.h"
#import "TestView2.h"


@implementation RootViewController

@synthesize testView2;

- (IBAction)didPressLink:(id)sender {
	
	DBLoginController* controller = [[DBLoginController new] autorelease];
	controller.delegate = self;
	[controller presentFromController:self];
	
    
}

-(void) segmentAction: (UISegmentedControl *) sender {
	
	NSLog(@"%0d", sender.selectedSegmentIndex + 1);
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	// titulo rectangulo blanco
	//self.navigationItem.titleView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f,0.0f, 120.0f, 36.0f)] autorelease];
	//titulo nombre aplicacion
	self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
	// titulo texto cualquiera
	//self.title = @"Conectarse";
	
   // codigo para agregar barra
	/*// Create the segmented control 
	NSArray *buttonNames = [NSArray arrayWithObjects:@"One", @"Two",@"Three", @"Four", @"Five", @"Six", nil]; 
	UISegmentedControl* segmentedControl = [[UISegmentedControl alloc]  initWithItems:buttonNames];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar; 
	segmentedControl.momentary = YES; 
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	// Add it to the navigation bar 
	self.navigationItem.titleView = segmentedControl; 
	[segmentedControl release];*/
	
	
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [testView2 release];
	[super dealloc];

}

#pragma mark DBLoginControllerDelegate methods

- (void)loginControllerDidLogin:(DBLoginController*)controller {
    //[self updateButtons];
	NSLog(@"deberia entrar para mostrar");
	testView2 = [[[TestView2 new] initWithFilePath:@"/"] autorelease];
    [self.navigationController pushViewController:testView2 animated:YES];
}

- (void)loginControllerDidCancel:(DBLoginController*)controller {
	
}



@end
