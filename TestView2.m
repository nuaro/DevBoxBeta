//
//  TestView2.m
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 09-11-10.
//  Copyright 2010 UVM. All rights reserved.
//

#import "TestView2.h"



@implementation TestView2

@synthesize filePath, testView3, textEditor, activityView, to_path, pathAuxFile;
//inicializo con variable

-(id)initWithFilePath:(NSString*)initPath
{
	self = [super init];
	if (self != nil) {
		
		//set the file path
		if (initPath != nil) {
			self.filePath = initPath;
		}
		
	}
	return self;
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
	//NSString * theFile = [[NSBundle mainBundle] pathForResource:@"TPL" ofType:@"plist"];
	//tutorial = [[NSArray alloc] initWithContentsOfFile:theFile];
	[[self restClient] loadMetadata:self.filePath];
	//cambio nombre de titulo
	self.title = self.filePath;
	//[self.tableView reloadData];
	[super viewDidLoad];
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

- (void)viewWillAppear:(BOOL)animated {
	
	
	NSLog(@"aparece");
	 
	if(self.pathAuxFile){
		[self setWorking:YES];
		NSLog(@" archivo editado %@", self.pathAuxFile);
		NSLog(@" path archivo %@", self.to_path);
	//obtengo nombre archivo
    //fileName = [filePath lastPathComponent];
	//NSArray *viewContrlls=[[self navigationController] viewControllers];
	// sube archivo editado a dropbox
	[restClient uploadFile:[self.to_path lastPathComponent] toPath:[self.to_path stringByDeletingLastPathComponent] fromPath:self.pathAuxFile];
	
	//[viewContrlls lastObject];
	}
}




- (void)dealloc {
	//[filePath release];
	//[testView3 release];
	[activityView release];
    [super dealloc];
}

#pragma mark private metods
- (NSString*)auxPath:(NSString*)name {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:name];
}

-(void)hideActivityViewer
{
	[[[activityView subviews] objectAtIndex:0] stopAnimating];
	[activityView removeFromSuperview];
	activityView = nil;
}

-(void)showActivityViewer
{
	[activityView release];
	activityView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
	activityView.backgroundColor = [UIColor blackColor];
	activityView.alpha = 0.5;
	
	UIActivityIndicatorView *activityWheel = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(self.view.bounds.size.width / 2 - 12, self.view.bounds.size.height / 2 - 12, 24, 24)];
	activityWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	activityWheel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
									  UIViewAutoresizingFlexibleRightMargin |
									  UIViewAutoresizingFlexibleTopMargin |
									  UIViewAutoresizingFlexibleBottomMargin);
	[activityView addSubview:activityWheel];
	[activityWheel release];
	[self.view addSubview: activityView];
	[activityView release];
	
	[[[activityView subviews] objectAtIndex:0] startAnimating];
}





- (void)setWorking:(BOOL)isWorking {
    if (working == isWorking) return;
    working = isWorking;
    
    if (working) {
		NSLog(@"esta trabajando");
		[self showActivityViewer];
    } else { 
		NSLog(@"No esta trabajando");
        [self hideActivityViewer];
    }
    //nextButton.enabled = !working;
}




#pragma mark table view metods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return tutorial.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell * RowContent =	[tableView dequeueReusableCellWithIdentifier:@"MyCell"];
	NSString* pathAux;
	if (RowContent == nil){
		RowContent = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
	}
	pathAux = [[tutorial objectAtIndex:indexPath.row] objectForKey: @"path"];
	
	
	RowContent.textLabel.text =[pathAux lastPathComponent];
	
	//[self setupDocumentControllerWithURL:pathAux];
	
	// test
	//RowContent.imageView.image = [docInteractionController.icons objectAtIndex:iconCount - 1];
	//NSString *fullPath;    // Assume this exists.
	//NSImage *theIcon;
	
	//theIcon = [NSWorkspace  iconForFile:fullPath] retain];
	//[theIcon setSize:NSMakeSize(128.0,128.0)];
	
	//
	
	
	return RowContent;
	
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
/*- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"selecciono 1");
	testView3 = [[[TestView2 new] initWithFilePath:@"/Photos"] autorelease];
    [self.navigationController pushViewController:testView3 animated:YES];
	return nil;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString* path =  [[tutorial objectAtIndex:indexPath.row] objectForKey: @"path"];
	NSNumber* isdir = [[tutorial objectAtIndex:indexPath.row] objectForKey: @"isDirectory"];
	//NSLog(@"%@",[tutorial objectAtIndex:[indexPath row]]);
	if ([isdir boolValue]) {
		testView3 = [[[TestView2 new] initWithFilePath:path] autorelease];
		[self.navigationController pushViewController:testView3 animated:YES];
	}
	else {
		[self setWorking:YES];
		self.to_path = path;
		self.pathAuxFile = [self auxPath:[path lastPathComponent]];
		[self.restClient loadFile:path  intoPath: self.pathAuxFile];
		
		
		
		// test para preview de archivo desrrollar mas tarde
		// for case 3 we use the QuickLook APIs directly to preview the document -
		//QLPreviewController *previewController = [[QLPreviewController alloc] init];
		//previewController.dataSource = self;
		//previewController.delegate = self;
		
		// start previewing the document at the current section index
		//previewController.currentPreviewItemIndex = path;
		//[self presentModalViewController:previewController animated:YES];
		//[previewController release];
		// fin test a desarrollar
		
		
		
	}

	
	//NSLog(@"%d",[[tutorial objectAtIndex:[indexPath row]] isAbsolutePath]);
	
	
	
}

#pragma mark DBRestClientDelegate methods

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
  
    NSMutableArray* arrayDropBox = [NSMutableArray new];
	for (DBMetadata* child in metadata.contents) {
    	
		NSMutableDictionary *dicDropBox = [NSMutableDictionary dictionary];
		[dicDropBox setObject: child.path forKey: @"path" ];
		[dicDropBox setObject:[NSNumber numberWithBool: child.isDirectory] forKey: @"isDirectory"];
		[dicDropBox setObject: child.icon forKey: @"icon"];
		[arrayDropBox addObject:dicDropBox];
		//[dicDropBox release];
		//NSLog(@"%@",child.path);
		//NSLog(@"%d",child.isDirectory);
		//NSLog(@"%@",child.icon);
	}
	
	[tutorial release];
    tutorial = arrayDropBox;
	
	//recargo tabla
	[self.tableView reloadData];
	
	
	

	
	
    
}

- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
    
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadMetadataFailedWithError: %@", [error localizedDescription]);
    
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath contentType:(NSString*)fileType {
	[self setWorking:NO];
	textEditor = [[[TextEditViewController new] initWithFilePath:destPath toPath:self.to_path] autorelease];
	[self.navigationController pushViewController:textEditor animated:YES];
	NSLog(@"aca deberia pasar");
	//NSLog(destPath);
  
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error {
	
	NSLog(@"error carga archivo");
    
}


// metods for handle files


- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
	[self setWorking:NO];
	NSLog(@"error subida archivo");
    
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath  {
	[self setWorking:NO];
	NSLog(@"subido archivo");
    
}

- (DBRestClient*)restClient {
    if (restClient == nil) {
    	restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    	restClient.delegate = self;
    }
    return restClient;
}




@end
