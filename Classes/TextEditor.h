//
//  TextEditor.h
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 26-11-10.
//  Copyright 2010 UVM. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TextEditor : NSObject {
	NSString* filePath;
	NSString* fileName;
	NSString* fileContent;
	NSData *  dataFile;
	NSFileHandle* file;
	
}

@property (nonatomic, retain) NSString* filePath;
@property (nonatomic, retain) NSString* fileName;
@property (nonatomic, retain) NSString* fileContent;
@property (nonatomic, retain) NSData* dataFile;
@property (nonatomic, retain) NSFileHandle* file;;

-(id)initWithFilePath:(NSString*)initPath;
-(void)loadFile;
-(void)saveFile;
@end
