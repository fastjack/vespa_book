//
//  AppController.h
//  SpeakLine
//
//  Created by Martin Maciaszek on 27.12.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *textField;
	NSSpeechSynthesizer *speechSynth;
	IBOutlet NSButton *stopButton;
	IBOutlet NSButton *startButton;
	IBOutlet NSTableView *tableView;
	NSArray *voiceList;
}
- (IBAction)sayIt:(id)sender;
- (IBAction)stopIt:(id)sender;
@end
