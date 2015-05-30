//
//  textEditor.m
//  textEdit
//
//  Created by Rodrigo Aguilar on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TextEditor.h"


@implementation TextEditor

@synthesize filePath, fileName, fileContent, dataFile, file;

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

-(void)loadFile {
	NSError *fileError = nil;
	fileName = [filePath lastPathComponent];
	fileContent = [[NSString alloc] initWithContentsOfFile:filePath
												  encoding:NSASCIIStringEncoding 
													 error:&fileError];
	if (fileError == nil) {
		// NSLog(@"OK");
	}
	else {
		NSLog(@"Error reading file: %@", [fileError localizedDescription]);
	}
	
}

-(void)saveFile {
	
	self.dataFile = [fileContent dataUsingEncoding:NSUTF8StringEncoding];
	//self.file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
	self.file = [NSFileHandle fileHandleForWritingAtPath:filePath];
	//[file seekToEndOfFile];
	[file truncateFileAtOffset: 0];
	[file writeData: dataFile];
	[file closeFile];
	
}

-(void)dealloc {
	[filePath release];
	[fileName release];
	[fileContent release];
	[super dealloc];
}

@end
