//
//  TextEditViewController.h
//  DevBoxBeta
//
//  Created by Hernán Antonio Zambrano Astete on 26-11-10.
//  Copyright 2010 UVM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEditor.h"

@interface TextEditViewController : UIViewController {
	IBOutlet UITextView *textContent;
	NSString* filePath, * savePath;
	TextEditor *currentFile;
	BOOL viewPushed;
	

	//IBOutlet UILabel *fileName;
}



@property (nonatomic, retain) IBOutlet UITextView* textContent;
@property (nonatomic, retain) NSString* filePath, * savePath;
@property (nonatomic, readonly) TextEditor *currentFile;

//@property (nonatomic, retain) IBOutlet UILabel* fileName;


-(id)initWithFilePath:(NSString*)initPath toPath:(NSString*)to_path;
-(void)initializeView;
@end

