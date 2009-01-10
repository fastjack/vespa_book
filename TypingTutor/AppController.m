//
//  AppController.m
//  TypingTutor
//
//  Created by Martin Maciaszek on 11.01.09.
//  Copyright 2009 Martin Maciaszek. All rights reserved.
//

#import "AppController.h"
#import "BigLetterView.h"

#define MAX_COUNT (100)
#define COUNT_STEP (5)

@implementation AppController

- (id)init
{
	[super init];
	
	// Create an array of letters
	letters = [[NSArray alloc] initWithObjects:@"a", @"s", @"d", @"f", @"j", @"k", @"l", @"ö", nil];
	
	// Seed the random number generator
	srandom(time(NULL));
	return self;
}

- (void)awakeFromNib
{
	[self showAnotherLetter];
}

- (void)resetCount
{
	[self willChangeValueForKey:@"count"];
	count = 0;
	[self didChangeValueForKey:@"count"];
}

- (void)incrementCount
{
	[self willChangeValueForKey:@"count"];
	count = count + COUNT_STEP;
	if (count > MAX_COUNT) {
		count = MAX_COUNT;
	}
	[self didChangeValueForKey:@"count"];
}

- (void)showAnotherLetter
{
	// Choose random numbers until you get a different
	// number than the last time
	int x = lastIndex;
	while (x == lastIndex) {
		x = random() % [letters count];
	}
	lastIndex = x;
	[outLetterView setString:[letters objectAtIndex:x]];
	
	// Star the count again
	[self resetCount];
}

- (IBAction)stopGo:(id)sender
{
	if (timer == nil) {
		NSLog(@"Starting");
		
		// Create a timer
		timer = [[NSTimer scheduledTimerWithTimeInterval:0.1
												  target:self
												selector:@selector(checkThem:)
												userInfo:nil
												 repeats:YES] retain];
	} else {
		NSLog(@"Stopping");
		
		// Invalidate and release the timer
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}

- (void)checkThem:(NSTimer *)aTimer
{
	if ([[inLetterView string] isEqual:[outLetterView string]]) {
		[self showAnotherLetter];
	}
	if (count == MAX_COUNT) {
		NSBeep();
		[self resetCount];
	} else {
		[self incrementCount];
	}
}
@end
