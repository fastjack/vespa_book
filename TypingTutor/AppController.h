//
//  AppController.h
//  TypingTutor
//
//  Created by Martin Maciaszek on 11.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BigLetterView;

@interface AppController : NSObject {
	// Outlets
	IBOutlet BigLetterView *inLetterView;
	IBOutlet BigLetterView *outLetterView;
	IBOutlet NSWindow *speedSheet;
	
	// Data
	NSArray *letters;
	int lastIndex;
	
	// Time
	NSTimer *timer;
	int count;
	int stepSize;
}
- (IBAction)stopGo:(id)sender;
- (IBAction)showSpeedSheet:(id)sender;
- (IBAction)endSpeedSheet:(id)sender;
- (void)incrementCount;
- (void)resetCount;
- (void)showAnotherLetter;
@end
